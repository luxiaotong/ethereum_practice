var contractABI = [
    {
        "inputs": [],
        "name": "data",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function",
        "constant": true
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_data",
                "type": "string"
            }
        ],
        "name": "set",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "get",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function",
        "constant": true
    }
];
var contractAddress = '0x10f67E7622F632E61268364a5F0329AcAfFfAA38';
var web3 = new Web3('http://localhost:9545');
var simpleStorage = new web3.eth.Contract(contractABI, contractAddress);

document.addEventListener('DOMContentLoaded', () => {
    const $setData = document.getElementById("setData");
    const $data = document.getElementById("data");

    let accounts = [];
    web3.eth.getAccounts()
        .then(_accounts => {
            accounts = _accounts;
        })

    const getData = () => {
        simpleStorage.methods.get().call()
            .then(result => {
                $data.innerHTML = result;
            });
    }
    getData();

    $setData.addEventListener('submit', e => {
        e.preventDefault();
        const data = e.target.elements[0].value;
        simpleStorage.methods.set(data).send({ from: accounts[0] })
            .then(getData);
    });
});