const Hello = artifacts.require("Hello");

contract("Hello", accounts => {
    it("test Hello", async () => {
        let instance = await Hello.deployed();
        let greeting = await instance.greeting.call();
        console.log(greeting);
        instance.setGreeting("hi");
        greeting = await instance.greeting.call();
        console.log(greeting);
    });
    // it("test console", () => console.log("cccccccc"));
    // console.log("dddddd");
});