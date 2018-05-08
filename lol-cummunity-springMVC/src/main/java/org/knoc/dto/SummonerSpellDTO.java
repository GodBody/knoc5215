package org.knoc.dto;

public class SummonerSpellDTO {
	
	private ImageDTO image;
	private int id;
	private String name;
	
	public ImageDTO getImage() {
		return image;
	}
	public void setImage(ImageDTO image) {
		this.image = image;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "SummonerSpellDTO [image=" + image + ", id=" + id + ", name=" + name + "]";
	}
	
	
	
	
	
	
	
}
