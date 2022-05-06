var contractABI = [
    {
        "inputs": [],
        "name": "hello",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "pure",
        "type": "function"
    }
];
var contractAddress = '0x10f67E7622F632E61268364a5F0329AcAfFfAA38';
var web3 = new Web3('http://localhost:9545');
var helloWorld = new web3.eth.Contract(contractABI, contractAddress);

document.addEventListener('DOMContentLoaded', () => {
    helloWorld.methods.hello().call()
        .then(result => {
            document.getElementById('hello').innerHTML = result;
        });
});
