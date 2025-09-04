local M = {}

function M.parse(lines)
	local slides = {}
	local current_slide = {}

	for _, line in ipairs(lines) do
		if line:match("^#") then
			if #current_slide > 0 then
				table.insert(slides, current_slide)
			end
			current_slide = { line }
		else
			table.insert(current_slide, line)
		end
	end
	if #current_slide > 0 then
		table.insert(slides, current_slide)
	end
	return slides
end

return M
