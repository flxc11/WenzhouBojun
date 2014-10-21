<%
Class CNVP_DBCache
	private m_CacheName, m_CanCache, m_DBPath, m_Conn, m_Rs, m_cache
	
	Private Sub Class_Initialize()
		m_CanCache = true
		m_CacheName = "CNVP_Conn"
		m_DBPath= Server.MapPath("/DataBase/DataBase.mdb")
	End Sub
	
	'缓存名称
	Public Property Let CacheName(ByVal oData)
		m_CACHENAME = oData
	End Property
	Public Property Get CacheName()
		CacheName = m_CacheName
	End Property

	'是否缓存
	Public Property Let CanCache(ByVal oData)
		m_CanCache = oData
	End Property
	Public Property Get CanCache()
		CanCache = m_CanCache
	End Property
	
	'数据库路径
	Public Property Let DBPath(ByVal oData)
		m_DBPath = oData
	End Property
	Public Property Get DBPath()
		DBPath = m_DBPath
	End Property
	
	Public Property Get DBConn()
		set DBConn = m_Conn
	End Property

	public function Open()
		if isobject(application(m_CacheName)) and m_CanCache=true then
			set m_Conn = application(m_CacheName)
		else
			set m_Conn = server.createObject("Adodb.connection")
			m_Conn.open "provider=microsoft.jet.oledb.4.0;data source=" & m_DBPath
			application.lock()
			set application(m_CacheName) = m_Conn
			application.unlock()
		end if
		if m_conn.state <> 1 then
			m_Conn.open "provider=microsoft.jet.oledb.4.0;data source=" & m_DBPath
		end if	
	end function
	
	public function Close()
		set m_rs = nothing
		if m_conn.state = 1 then
			m_conn.close()
			set m_conn = nothing
		end if
	end function
	
	public function RS(byval SqlString, byval var1, byval var2)
		set m_Rs = server.createobject("Adodb.recordset")
		m_Rs.open SqlString, m_conn, var1, var2
		set RS = m_Rs
	end function
	
	public function SQL(ByVal SQLStr, byref a)
		m_cache = m_Conn.execute(SQLStr,a)
		if isobject(m_cache) then
			set SQL = m_cache
		else
			SQL = m_cache
		end if
	end function
end class
%>