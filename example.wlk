class Nave {
  var property velocidad
  var property direccion

  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(100000)
  }
  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }
  method irHaciaElSol() {
    direccion = 10
  }
  method escaparDelSol() {
    direccion = -10
  }
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }
  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }
}
class NaveBaliza inherits Nave {
  var property colorDeBaliza

  method cambiarColorDeBaliza(colorNuevo) {
    colorDeBaliza = colorNuevo
  }
  method prepararViaje() {
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }
}
class NaveDePasajeros inherits Nave {
  var property cantidadDePasajeros
  var property racionesDeComida
  var property racionesDeBebidas

  method cargarRacionesDeComida(cantidad) {
    racionesDeComida += cantidad
  }
  method descargarRacionesDeComida(cantidad) {
    racionesDeComida = (racionesDeComida - cantidad).max(0)
  }
  method cargarRacionesDeBebidas(cantidad) {
    racionesDeBebidas += cantidad
  }
  method descargarRacionesDeBebidas(cantidad) {
    racionesDeBebidas = (racionesDeBebidas - cantidad).max(0)
  }
  method prepararViaje() {
    self.cargarRacionesDeComida(4 * cantidadDePasajeros)
    self.cargarRacionesDeBebidas(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }
}
class NaveDeCombate inherits Nave {
  var estaInvisible = null
  var misilesDesplegados = null
  const mensajesEmitidos = []

  method ponerseVisible() {
    estaInvisible = false
  }
  method ponerseInvisible() {
    estaInvisible = true
  }
  method estaInvisible() = estaInvisible
  method desplegarMisiles() {
    misilesDesplegados = true
  }
  method replegarMisiles() {
    misilesDesplegados = false
  }
  method misilesDesplegados() = misilesDesplegados
  method emitirMensaje(mensaje) {
    mensajesEmitidos.add(mensaje)
  }
  method mensajesEmitidos() = mensajesEmitidos
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method emitioMensaje(mensaje) = mensajesEmitidos.count(mensaje)
  method esEscueto() = mensajesEmitidos.all({m => m.length() <= 30})
  method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendo a mision")
  }
}