local ok, plugins = pcall(require, "plugins.before")

if ok then
	print("Plugins are loaded")
	require("plugins.after")
end

