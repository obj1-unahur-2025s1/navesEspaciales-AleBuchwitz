class Nave {
  var property velocidad
  var property direccion
  var combustible

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
  method cargarCombustible(cantidad) {
    combustible += combustible
  }
  method descargarCombustible(cantidad) {
    combustible = (combustible - cantidad).max(0)
  }
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method estaTranquila() = combustible >= 400 && velocidad <= 12000
  method estaDeRelajo() = self.estaTranquila()
}
class NaveBaliza inherits Nave {
  var property colorDeBaliza
  var cantidadDeCambiosDeBaliza = 0

  method cambiarColorDeBaliza(colorNuevo) {
    colorDeBaliza = colorNuevo
    cantidadDeCambiosDeBaliza += 1
  }
  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    cantidadDeCambiosDeBaliza += 1
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() = super() && colorDeBaliza != "rojo"
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar() {
    self.irHaciaElSol()
  }
  method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }
  method tienePocaActividad() = cantidadDeCambiosDeBaliza == 0
}
class NaveDePasajeros inherits Nave {
  var property cantidadDePasajeros
  var property racionesDeComida
  var property racionesDeBebidas
  var racionesDeComidasServidas = 0

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
  override method prepararViaje() {
    super()
    self.cargarRacionesDeComida(4 * cantidadDePasajeros)
    self.cargarRacionesDeBebidas(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar() {
    velocidad = velocidad *2
  }
  method avisar() {
    racionesDeComida -= cantidadDePasajeros
    racionesDeComidasServidas = racionesDeComidasServidas + cantidadDePasajeros
    racionesDeBebidas -= cantidadDePasajeros * 2
  }
  method tienePocaActividad() = racionesDeComidasServidas < 50
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
  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendo a mision")
  }
  override method estaTranquila() = super() && !misilesDesplegados
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }
}
class NaveHospital inherits NaveDePasajeros {
  var tieneQuirofanosPreparados
  method prepararQuirofanos() {
    tieneQuirofanosPreparados = true
  }
  method quirofanosPreparados() = tieneQuirofanosPreparados
  override method estaTranquila() = super() && !self.quirofanosPreparados()
  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}
class NaveDeCombateSigilosa inherits NaveDeCombate {
  override method estaTranquila() = super() && self.estaInvisible()
  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}