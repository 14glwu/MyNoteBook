/**
 * 
 */
package Entity;

/**
 * @author lin
 *事件记录类，对应数据库中的事件记录
 */
public class Record {
	private Integer id;
	private String title;//标题
	private String content;//内容
	private String time;//时间
	
	public Record(){}
	
	public Record(String title,String content,String time){
		this.title=title;
		this.content=content;
		this.time=time;
	}
	public Record(Integer id,String title,String content,String time){
		this.id=id;
		this.title=title;
		this.content=content;
		this.time=time;
	}

	/**
	 * @return id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id 要设置的 id
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title 要设置的 title
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content 要设置的 content
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return time
	 */
	public String getTime() {
		return time;
	}

	/**
	 * @param time 要设置的 time
	 */
	public void setTime(String time) {
		this.time = time;
	}
	

}
