package ecs505.lab2.dice;

public interface GameItem {

	/**
	 * 
	 * @param gameType
	 */
	boolean isSuitableForTheGame(GameType gameType);

}