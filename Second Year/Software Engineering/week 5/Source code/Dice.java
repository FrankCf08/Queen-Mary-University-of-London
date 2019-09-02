package ecs505.lab2.dice;

public abstract class Dice implements GameItem {

	private int numberOfSides;
	private int numberRolled;

	public int getNumberOfSides() {
		return this.numberOfSides;
	}

	/**
	 * 
	 * @param numberOfSides
	 */
	public void setNumberOfSides(int numberOfSides) {
		this.numberOfSides = numberOfSides;
	}

	public int getNumberRolled() {
		return this.numberRolled;
	}

	/**
	 * 
	 * @param numberRolled
	 */
	public abstract void roll(int numberRolled);

	/**
	 * 
	 * @param rolledOn
	 * @param rolledThrown
	 */
	public abstract void trickRoll(SurfaceType rolledOn, Force rolledThrown);

}