/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */

package com.mundo.mundial;

public class Jugador {
    private String nombreJugador;
    private int edad;
    private double altura;
    private double peso;
    private double salario;
    private String posicion;
    private String foto;
    private String NombreEquipo;

    public Jugador() {
    }

    public Jugador(String nombreJugador, int edad, double altura, double peso, double salario, String posicion, String foto, String NombreEquipo) {
        this.nombreJugador = nombreJugador;
        this.edad = edad;
        this.altura = altura;
        this.peso = peso;
        this.salario = salario;
        this.posicion = posicion;
        this.foto = foto;
        this.NombreEquipo = NombreEquipo;
    }

    public String getNombreEquipo() {
        return NombreEquipo;
    }

    public void setNombreEquipo(String NombreEquipo) {
        this.NombreEquipo = NombreEquipo;
    }

    

    public String getNombreJugador() {
        return nombreJugador;
    }

    public void setNombreJugador(String nombreJugador) {
        this.nombreJugador = nombreJugador;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getAltura() {
        return altura;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }

    public String getPosicion() {
        return posicion;
    }

    public void setPosicion(String posicion) {
        this.posicion = posicion;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
}
