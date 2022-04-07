echo "Checking alu.v"
iverilog -o iitb_risc alu.v

echo "Checking aluCtrl.v"
iverilog -o iitb_risc aluCtrl.v

echo "Checking dataMem.v"
iverilog -o iitb_risc dataMem.v

echo "Checking instrMem.v"
iverilog -o iitb_risc instrMem.v

echo "Checking mux.v"
iverilog -o iitb_risc mux.v

echo "Checking registerBank.v"
iverilog -o iitb_risc registerBank.v