package com.example.domain;

import java.util.Date;

public class QuestionVO {
	private int qbno;
	private String qtitle;
	private String qcontent;
	private String qimage;
	private String qwriter;
	private Date qregdate;
	private Date qupdatedate;
	private int qviewcnt;
	
	
	public int getQbno() {
		return qbno;
	}
	public void setQbno(int qbno) {
		this.qbno = qbno;
	}
	public String getQtitle() {
		return qtitle;
	}
	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public String getQimage() {
		return qimage;
	}
	public void setQimage(String qimage) {
		this.qimage = qimage;
	}
	public String getQwriter() {
		return qwriter;
	}
	public void setQwriter(String qwriter) {
		this.qwriter = qwriter;
	}
	public Date getQregdate() {
		return qregdate;
	}
	public void setQregdate(Date qregdate) {
		this.qregdate = qregdate;
	}
	public Date getQupdatedate() {
		return qupdatedate;
	}
	public void setQupdatedate(Date qupdatedate) {
		this.qupdatedate = qupdatedate;
	}
	public int getQviewcnt() {
		return qviewcnt;
	}
	public void setQviewcnt(int qviewcnt) {
		this.qviewcnt = qviewcnt;
	}
	@Override
	public String toString() {
		return "QuestionVO [qbno=" + qbno + ", qtitle=" + qtitle + ", qcontent=" + qcontent + ", qimage=" + qimage
				+ ", qwriter=" + qwriter + ", qregdate=" + qregdate + ", qupdatedate=" + qupdatedate + ", qviewcnt="
				+ qviewcnt + "]";
	}
	
	
	
	
}
