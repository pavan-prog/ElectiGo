package voting.application.news.entities;

import java.sql.Date;

public class News {
	private int id;
	private String title;
	private String description;
	private String category;
	private Date datePosted;
	private String videoLink; 

	public int getId() { return id; }

	public void setId(int id) { this.id = id; } 
	public String getTitle() { return title; } 
	public void setTitle(String title) { this.title = title; }
	public String getDescription() { return description; } 
	public void setDescription(String description) {this.description = description; }
	public String getCategory() { return category; }
	public void setCategory(String category) { this.category =  category; } 
	public Date getDatePosted() { return datePosted; } 
	public void setDatePosted(Date datePosted) { this.datePosted = datePosted; }
	public String getVideoLink() { return videoLink; } 
	public void setVideoLink(String videoLink) { this.videoLink = videoLink; } 
}