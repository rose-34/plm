# plm用program实现table栏位的数据呈现

在需要使用程式的那个栏位的setting中填写：
1、program  <填写程式名称>
2、function   <填写方法名称>
3、Column Type   <programHTMLOutput>

编写好代码后，在MQL中compile
insert prog 程式地址（程式名称全名也要写，带.java）
compile prog 程式名（此处不需要.java）



PCR OE客户栏位数据：
Expression:
to[CSTC_SpecItem2Project].from.to[CSTC_RFQ2SpecItem].from.attribute[CSTC_RFQ_CustomerName]
---------------------------------------------------------------------------------------------------------------------------------------------------------------

Java相关知识点：(参考程式：CSTC_TestReq_RR_mxJPO.java)
1、创建关联（from Project Space to TestReq_RR）
2、edit的时候如果修改项目名称，要先断掉之前的连接，再创建新的连接。
3、断关联的方法：
//Expand Project Space by Test Request
			StringList busSel = new StringList();
			busSel.addElement( DomainObject.SELECT_ID ); //DomainObject可以展物件，自己定义的物件使用方法为：busSel.addElement( "attribute[CSTC_TestReq_TireId]" );
			StringList relSel = new StringList();
			relSel.addElement( DomainRelationship.SELECT_ID );
			

			MapList mplPrectSpace = cTestReqObj.getRelatedObjects( context
					, REL_CSTC_Project2TestReq , DomainObject.TYPE_PROJECT_SPACE
					, busSel, relSel , true , false , (short)1 , "" , "" , 0 );
					
			//通过TestReq_RR展project Space，寻找projectID.
			cTestReqObj:通过谁展，domainobject就要用谁的
			REL_CSTC_Project2TestReq:需要展的关联的name
			DomainObject.TYPE_PROJECT_SPACE：被展的Type，可直接写type名称
			busSel，relSel：固定写法
			true，false：被展的type是from端，第一个参数就是true，第二个是false；or反过来
			(short)1:关联要展几层
			倒数第二和倒数第三是where条件
			最后一个参数目前为止一直填0
			
			System.out.println("mplPrectSpace size = " + mplPrectSpace.size());
			RelationshipType relationType = new RelationshipType( REL_CSTC_Project2TestReq );
			
			if (mplPrectSpace.size() > 0){
				Map mapProjectSpace = (Map)mplPrectSpace.get(0);
				String strOldProectID = (String)mapProjectSpace.get(DomainObject.SELECT_ID); //old project id
				String strRelID = (String)mapProjectSpace.get(DomainRelationship.SELECT_ID);   //关联的id
				
				System.out.println("strOldProectID = " + strOldProectID);
				
				if (!strOldProectID.equals(strNewPrjId)){
					System.out.println("disconnect old relation.......... ");
					
					//disconnect old relation
					DomainRelationship.disconnect(context, strRelID);
					
					System.out.println("add new relation.......... ");
					//add new relation
					cTestReqObj.addFromObject(context, relationType, strNewPrjId);
				}
			}else{
				//add new relation
				cTestReqObj.addFromObject(context, relationType, strNewPrjId);
				
				
				
			}
			
			AEFGeneralSearchResults（table）  最后一列
			
-------------------------------------------------------------------------------------------------------------------------------------------------------			
2、range program
用来为condition中TireId列抓取前面Test Tire的TireId值。
在其webform的attribute中设置如下：
range function：<function 名称>
range program:<program 名称>
/*参考物件：CSTC_TestReq_Condition 的TireId列，程式名称为：CSTC_TestReq_Condition:TireId*/
-------------------------------------------------------------------------------------------------------------------------------------------------------	
3、往某个页签的table中插入数据（Create Object）

1)先创建object
DomainObject ResultRRObj = new DomainObject();
String strVault = "eService Production";
ResultRRObj.createObject(context, "CSTC_TestReq_Result_RPK", ResultRRName, "1", "CSTC_TestReq_Sub", strVault);
CSTC_TestReq_Result_RPK:所使用的type
ResultRRName：auto name（使用Object Generator或者程式<strPrefix>）
1：版本
CSTC_TestReq_Sub：policy
strVault：目前就使用“eService Production”

2）给所需attribute赋值
ResultRRObj.setAttributeValue(context, "CSTC_TestReq_TireId", strTireId);
ResultRRObj.setAttributeValue(context, "CSTC_TestReq_Pressure", PressureResult[i]);
ResultRRObj.setAttributeValue(context, "CSTC_TestReq_Load", LoadResult[j]);
ResultRRObj.setAttributeValue(context, "CSTC_TestReq_Speed", SpeedResult[k]);

3）创建关联
ResultRRObj.addFromObject(context, new RelationshipType( REL_CSTC_TestCondition2TestResult ), cConditionId);
ResultRRObj.addFromObject(context, new RelationshipType( REL_CSTC_TestReq2TestResult ), strTestReqId);

/*参考物件：RR测试委托单的测试结果，程式名称:CSTC_TestReq_Condition:GetResultFromCondition*/
-------------------------------------------------------------------------------------------------------------------------------------------------------	

流程(关卡的设定)：
name:关卡的名称
flow-doc-state:属于policy的哪个state
validator：check(参考物件：Test Request RR的流程中Waitting Tire关卡)
listener：要做什么事情（JPO）
leave-rule:<and/or>  (当签核者选择了多个时，and需要每个人都签核才能到下一关，or只要有一个人签核即可通过)
signer：签核者
签核者要抓取系统既有的attribute时，设定如下：
value="${FlowDoc.getAttributeValue('CSTC_TestReq_TestEngineer')}"
when=""    (设定条件)
assignment="Tire Test."  (提示信息)
签核者要抓取role时，设定如下：
value="${Flow.getMembersByRole('CSTC_SM')}"
when="${FlowDoc.getAttributeValue('CSTC_TestReq_Site_RR') == 'CSTC'}"
assignment="Please Review Test Request."


设定整个流程在哪个条件下启用：
flowdoc-setting:set FlowDoc
单击set FlowDoc，设定条件。有by program和by when condition两种方式，目前使用的是by when condition，在when处填入控制条件即可。




流程中驳回给原申请人的设定：
${Flow.originator}(在return关卡的set signer里设定)

Sending Rule在matrix里做。
Sending rule收件人的设定：
attribute_CSTC_TestReq_TestEngineer           (CSTC_TestReq_TestEngineer为系统中既有的attribute)  
${FlowDoc.getAttributeValue('Originator')}    (发送mail给填单人)

流程的log档路径：
C:\enoviaV6R2015x\ENOVIA_DEV\logs\STI-Flow-2017-05-02_0.log

工作流程相关知识：
review可以退件，task不能退件；拉线的规则是从红点到蓝点。

设定流程是否可用：
点流程空白处，把active设为true。


Return关卡的terminate:
terminate-doc-state:设置终止时回到哪个state
-------------------------------------------------------------------------------------------------------------------------------------------------------	

设置command在哪个状态可见：
Access Expression
(attribute[CSTC_TestReq_TestEngineer]==context.user && current=='Work')
(current.access[modify] == true && current=='Create')
(owner==context.user && current=='Create')

emxIndentedTable.jsp   
-------------------------------------------------------------------------------------------------------------------------------------------------------	

在webform中要不要把policy show出来(在对应command的link里设showpolicy=true/false)
添加空白range：
在汇出的spinner文件中，直接添加range的值，再汇入。
-------------------------------------------------------------------------------------------------------------------------------------------------------	
给webform的attribute设置default值：
在需要设置值的attribute的setting页签中，填入如下设置：
Default:<需要显示的值>
-------------------------------------------------------------------------------------------------------------------------------------------------------	

attribute从系统中自动带出数据（Project Name）
1)单选
在webForm中attribute的link页签的"RangeHref"栏位设置如下：
 ${COMMON_DIR}/emxFullSearch.jsp?field=TYPES=type_ProjectSpace&table=AEFGeneralSearchResults&selection=single&HelpMarker=emxhelpfullsearch&showInitialResults=true
 TYPES      //要使用的type的注册名
 table      //要使用的table名，没要求就填上面的默认table（Person的注册type为type_Person，默认表为AEFPersonChooserDetails）
 selection   //选择格式（单选:single/多选:multiple）
 showInitialResults   //是否要在没有点击的时候直接搜寻
 选人时，默认显示员工编号，想要显示全名的话，需在attribute的setting页签中设置format:<user>
 
	/*
	  参考物件	
	  webForm[name=CSTC_TestReq_RR_Create]的attribute[name=CSTC_TestReq_PrjNm]
	*/
2)多选
在webForm中attribute的link页签的"RangeHref"栏位设置如下：
../programcentral/CSTC_SelectPersonDialogFS.jsp
使用此多选方式选人时，format:<user>并不能正确显示，只能在页面中显示最后一个选择的人。所以使用此方法时，应设置如下：
Field Type:<programHTMLOutput>
function:<showMultiplePerson>
program:<CSTC_Utility>
	/*
	  参考物件	
	  webForm[name=CSTC_TestReq_RR_Create]的attribute[name=CSTC_TestReq_PM]
	*/
-------------------------------------------------------------------------------------------------------------------------------------------------------		
给attribute的值添加链接：
在webform的attribute中设置如下：
Expression页签：
Expression:<$<to[relationship_CSTC_Project2TestReq].from.name>>
Link页签：
Link:<${COMMON_DIR}/emxTree.jsp?>
Settings页签：
<Alternate OID expression>  <$<to[relationship_CSTC_Project2TestReq].from.id>>
<Alternate Type expression>   <$<to[relationship_CSTC_Project2TestReq].from.type>>
	/*
	  参考物件	
	  webForm[name=CSTC_TestReq_RR_Create]的attribute[name=CSTC_TestReq_PrjNm]
	*/
-------------------------------------------------------------------------------------------------------------------------------------------------------	
java代码中的异常信息抓取多语系中的内容:
String strMsg= i18nNow.getI18nString("emxFramework.Message.CST_Get_DOT_Code.Error.Generate", FRAMEWORK_STR_RESOURCE, context.getSession().getLanguage());
throw new Exception(strMsg);
emxFramework.Message.CST_Get_DOT_Code.Error.Generate:定义的多语系
FRAMEWORK_STR_RESOURCE：先默认填此值
context.getSession().getLanguage()：获取当前语言
----------------------------------------------------------------------------------------------------------------------------------------------------------
系统功能：
1.创建RR测试委托单

2.开单人编辑RR测试委托单

3.开单人新增Tire Information中除Weight外的所有信息

4.开单人编辑Tire Information中除Weight外的所有信息

5.开单人新增Condition

6.开单人编辑Condition

7.测试工程师新增Test Device的信息

8.测试工程师编辑Test Device的信息

9.测试工程师维护测试结果

10.测试工程师维护Tire Information中的weight

11."我的项目"菜单下的"My Test"菜单，可浏览自己创建的所有RR测试委托单


