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

echo "Checking IF2ID_Stage.v"
iverilog -o iitb_risc IF2ID_Stage.v

echo "Checking ID2RR_Stage.v"
iverilog -o iitb_risc ID2RR_Stage.v

echo "Checking RR2EX_Stage.v"
iverilog -o iitb_risc RR2EX_Stage.v

echo "Checking EX2MM_Stage.v"
iverilog -o iitb_risc EX2MM_Stage.v

echo "Checking MM2WB_Stage.v"
iverilog -o iitb_risc MM2WB_Stage.v