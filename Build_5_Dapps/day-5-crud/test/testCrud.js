const Crud = artifacts.require('Crud');

contract("Crud", () => {
    let crud = null;
    before(async () => {
        crud = await Crud.deployed();
    });
    it("Should create a new user", async () => {
        await crud.create("Frank");
        const result = await crud.read(1);
        assert(result[0].toNumber() === 1);
        assert(result[1] === "Frank");
    });
    it("Should update a user", async () => {
        await crud.update(1, "Frank2");
        const result = await crud.read(1);
        assert(result[0].toNumber() === 1);
        assert(result[1] === "Frank2");
    });
    it("Should not update a non-existing user", async () => {
        try {
            await crud.update(2, "Frank3");
        } catch (e) {
            assert(e.message.includes("User does not exist!"));
            return;
        }
        assert(false);
    });
    it("Should destroy a user", async () => {
        await crud.destroy(1);
        try {
            await crud.read(1);
        } catch (e) {
            assert(e.message.includes("User does not exist!"));
            return;
        }
        assert(false);
    });
    it("Should not destroy a non-existing user", async () => {
        try {
            await crud.destroy(10);
        } catch (e) {
            assert(e.message.includes("User does not exist!"));
            return;
        }
        assert(false);
    });
});