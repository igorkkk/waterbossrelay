do
local ct=0
print("\n\n\n=========== _G table: ===========")
table.foreach(_G, print)
for _ in pairs(_G) do ct = ct + 1 end
print('#_G = '..ct); ct = 0
print("\n===== package.loaded table: =====")
if _G.package.loaded then table.foreach(_G.package.loaded, print) end
for _ in ipairs(debug.getregistry()) do ct = ct +1 end
print("=================================")
print('Reg: ', ct, 'Heap: '..node.heap()..' \n')
ct = nil
if dat then print('dat table:'); table.foreach(dat,print); print(' \n') end
end