해당 폴더는 C:\ 아래 다 두어, C:\upload가 주소가 되게 해주세요.

eclipse > servers > server.xml 파일 맨 아래에 

       <Context docBase="C:/upload" path="/bookService/upload" reloadable="true"/>
      <Context docBase="bookService" path="/bookService" reloadable="true" source="org.eclipse.jst.jee.server:bookService"/>
  
다음 두 줄을 추가해주세요.
.
.
.
.     
	<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" pattern="%h %l %u %t &quot;%r&quot; %s %b" prefix="localhost_access_log" suffix=".txt"/>
         <Context docBase="C:/upload" path="/bookService/upload" reloadable="true"/>
         <Context docBase="bookService" path="/bookService" reloadable="true" source="org.eclipse.jst.jee.server:bookService"/>
      </Host>
    </Engine>
  </Service>
</Server>

추가시 위치는 <valve ~ > 와 </h해당 폴더는 C:\ 아래 다 두어, C:\upload가 주소가 되게 해주세요.

eclipse > servers > server.xml 파일 맨 아래에 

       <Context docBase="C:/upload" path="/bookService/upload" reloadable="true"/>
      <Context docBase="bookService" path="/bookService" reloadable="true" source="org.eclipse.jst.jee.server:bookService"/>
  
다음 두 줄을 추가해주세요.
.
.
.
.     
	<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" pattern="%h %l %u %t &quot;%r&quot; %s %b" prefix="localhost_access_log" suffix=".txt"/>
         <Context docBase="C:/upload" path="/bookService/upload" reloadable="true"/>
         <Context docBase="bookService" path="/bookService" reloadable="true" source="org.eclipse.jst.jee.server:bookService"/>
      </Host>
    </Engine>
  </Service>
</Server>

추가시 위치는 <valve ~ > 와 </h



