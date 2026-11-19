local M = {}
local delay_ms = 2000
local states = {}
local group = vim.api.nvim_create_augroup('sv-diagnostic-delay', { clear = true })

local function is_sv(bufnr)
  local ft = vim.bo[bufnr].filetype
  return ft == 'verilog' or ft == 'systemverilog'
end

local function stop_timer(state)
  if state and state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end
end

local function schedule(bufnr)
  local state = states[bufnr]
  if not state then return end
  stop_timer(state)
  local elapsed_ms = (vim.uv.hrtime() - state.last_change) / 1e6
  local timer
  timer = vim.defer_fn(function()
    if states[bufnr] ~= state or state.timer ~= timer then return end
    state.timer = nil
    if vim.api.nvim_get_current_buf() ~= bufnr or vim.api.nvim_get_mode().mode:sub(1, 1) ~= 'i' then return end
    -- Override Insert-mode deferral only for this idle refresh.
    vim.diagnostic.show(nil, bufnr, nil, { update_in_insert = true })
  end, math.max(0, math.ceil(delay_ms - elapsed_ms)))
  state.timer = timer
end

vim.api.nvim_create_autocmd({ 'InsertEnter', 'TextChangedI', 'TextChangedP' }, {
  group = group,
  callback = function(event)
    if not is_sv(event.buf) then return end
    local state = states[event.buf] or {}
    states[event.buf] = state
    state.last_change = vim.uv.hrtime()
    schedule(event.buf)
  end,
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = group,
  callback = function(event)
    -- Late server results should use the time of the last edit, not restart the delay.
    if states[event.buf] then schedule(event.buf) end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufLeave', 'BufWipeout' }, {
  group = group,
  callback = function(event)
    stop_timer(states[event.buf])
    states[event.buf] = nil
  end,
})

function M.on_init(client)
  for _, is_pull in ipairs { false, true } do
    vim.diagnostic.config({ update_in_insert = false }, vim.lsp.diagnostic.get_namespace(client.id, is_pull))
  end
end

return M
