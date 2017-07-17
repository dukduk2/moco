package com.moco.jjim;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moco.member.MailService;
import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;

@Component
@EnableScheduling
public class jjimMail {

	@Inject
	private JjimService jjimService;
	@Inject
	private MailService mailService;
	
	@Scheduled(cron="0 0 12 * * ?")
	public void jjimMailService() throws Exception{		
		List<BasicMovieDTO> ar=new ArrayList<BasicMovieDTO>();
		ar=jjimService.jjimList();
		
		List<JjimDTO> jjimId=new ArrayList<JjimDTO>();
		
		List<MemberDTO> memberAr=new ArrayList<MemberDTO>();
		Date [] pubdate=new Date[ar.size()]; //영화 개봉일
		
		//비교일. 오늘 날짜.
		Calendar today = Calendar.getInstance();
		today.setTime(new Date());
		today.add(Calendar.DATE, 7);
		
		Date todayTest=today.getTime();
		
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		
		int out=0;
		
		for(int i=0;i<ar.size();i++){
			pubdate[i]=ar.get(i).getPub_date();
			
			String strToday=format.format(todayTest);
			Date today2=format.parse(strToday);
			
			out=Check(pubdate[i], today2);

			
			if(out==1){ //개봉예정일이 date보다 7일 이전이면
				System.out.println(ar.get(i).getTitle());
				jjimId=jjimService.jjimListId(ar.get(i).getNum());
				
				for(int j=0;j<jjimId.size();j++){
					System.out.println("id"+jjimId.get(j).getId());
					memberAr=jjimService.jjimListMember(jjimId.get(j).getId());
					
					for(int z=0;z<memberAr.size();z++){
						System.out.println("email"+memberAr.get(z).getEmail());
						
						String from="ezzang1@gmail.com";
						String to=memberAr.get(z).getEmail();
						String subject=memberAr.get(z).getName()+" 님 개봉예정일 안내";
						String contents=ar.get(i).getTitle()+" 의 개봉예정일은 "+ar.get(i).getPub_date()+"입니다.";
						mailService.sendMail(from, to, subject, contents);
					}
				}			
			}
		}
	
	}
		
	protected int Check(Date a, Date b){
		if(a.compareTo(b)==0){
			return 1;
		}else{
			return 0;
		}
	}
	
}
