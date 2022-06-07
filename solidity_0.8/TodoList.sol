// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    function updateText(uint _index, string calldata _text) external {
        todos[_index].text = _text;
        
        // 35116 gas
        // todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;

        // 34556 gas
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
    }
    
    function get(uint _index) external view returns(string memory, bool) {
        // storage - 29375 gas
        // memory - 29458 gas
        Todo storage todo = todos[_index];
        return(todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}