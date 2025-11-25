import { Sequelize, DataTypes } from "sequelize";

// inisialisasi Sequelize
const sequelize = new Sequelize({
    dialect: 'sqlite',
    storage: './todo.sqlite',
});
// mode to-do
const Todo = sequelize.define('Todo', {
    title: {
        type: DataTypes.STRING,
        allowNull: false
    },
    description: {
        type: DataTypes.STRING,
    },
    completed: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    }

});

sequelize.sync();
export default Todo;