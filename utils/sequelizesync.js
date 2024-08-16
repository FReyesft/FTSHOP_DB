sequelize.sync({ alter: true })
  .then(() => {
    console.log('Tablas sincronizadas con éxito');
  })
  .catch((error) => {
    console.error('Error al sincronizar las tablas:', error);
  });
