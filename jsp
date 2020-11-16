<%@include file="../common/emxNavigatorInclude.inc"%>
<%@include file="../common/emxNavigatorTopErrorInclude.inc"%>
<%@include file="../components/emxSearchInclude.inc"%>

<%@page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page language="java" import="java.io.*"%>


<%@page import="com.matrixone.apps.common.Search"%>
<%@page import="com.matrixone.apps.domain.util.FrameworkException"%>
<%@page import="com.matrixone.apps.domain.util.i18nNow"%>
<%@page import="com.sti.flow.utility.STILogger"%>

<jsp:useBean id="tableBean" class="com.matrixone.apps.framework.ui.UITable" scope="session" />

<%
	//FileWriter fw = new FileWriter("C://_bobo//Temp//bobo.log",true);
	//fw.write("hello\r\n");
	
	//Enumeration eNumParameters = emxGetParameterNames(request);
	//while( eNumParameters.hasMoreElements() ) {
	//	String parmName = (String)eNumParameters.nextElement();
	//	String parmValue = (String)emxGetParameter(request,parmName);
	//	//System.out.println( parmName+"=" + parmValue );
	//	fw.write(parmName+"=" + parmValue+"\r\n");
	//}

	//fw.close();
	
	String testReqId= emxGetParameter(request, "objectId");
	DomainObject testReqObj = new DomainObject(testReqId);	
	String currentState = testReqObj.getInfo( context , "current" );
	
	//Project Information
	String strName = testReqObj.getInfo(context, "name" );
	String strRequestSite = testReqObj.getAttributeValue(context, "CSTC_TestReq_RequestSite" );
	
	String strRequestFrom = testReqObj.getAttributeValue(context, "CSTC_TestReq_RequestFrom" );
	String strPrjNm = testReqObj.getAttributeValue(context, "CSTC_TestReq_PrjNm" );
	String strDeptId = testReqObj.getAttributeValue(context, "CSTC_TestReq_DeptId" );
	String strSupervisor = testReqObj.getAttributeValue(context, "CSTC_TestReq_Supervisor" );
	String strSupervisorContactExt = testReqObj.getAttributeValue(context, "CSTC_TestReq_SupervisorContactExt" );
	//String strPE = testReqObj.getAttributeValue(context, "CSTC_TestReq_PE" );
	String strCE = testReqObj.getAttributeValue(context, "CSTC_TestReq_CE" );
	String strPEContactExt = testReqObj.getAttributeValue(context, "CSTC_TestReq_PEContactExt" );
	

	//Testing Requirements
	String strTestSite = testReqObj.getAttributeValue(context, "CSTC_TestReq_TestSite" );
	String strReqDate = testReqObj.getAttributeValue(context, "CSTC_TestReq_ReqDate" );
	String strPriority = testReqObj.getAttributeValue(context, "CSTC_TestReq_Priority" );
	String strTopic = testReqObj.getAttributeValue(context, "CSTC_TestReq_Topic" );
	String strPurpose = testReqObj.getAttributeValue(context, "CSTC_TestReq_Purpose" );
	String strSampleInfor = testReqObj.getAttributeValue(context, "CSTC_TestReq_Sample_Infor" );
	String strTestItem = testReqObj.getAttributeValue(context, "CSTC_TestReq_TestItem" );
	String strTestMethod = testReqObj.getAttributeValue(context, "CSTC_TestReq_TestMethod" );
	String[] TestMethod = strTestMethod.split(",");
	String strWholeChemical = "";
	String strDSCTg = "";
	String strDSCTm = "";
	String strTGA = "";
	String strS144DR = "";
	String strGPC = "";
	String strPGC = "";
	String strGC = "";
	String strQA = "";
	String strItem = "";
	String strDeformulation="";
	String strMaterial="";
	String strAntioxidant="";
	String strAntioxidant2="";
	String strPhase="";
	String strSBR="";
	String strMicrostructure="";
	String strPurity="";
	String strAP="";
	String strSWD="";
	String strSSA="";
	String strUPD="";
	String strQoneR="";
	String strQtwoR="";
	String strQthreeR="";
	String strQfourR="";
	String strQfiveR="";
	String strOther="";
	
	
   
	String strTestItemDisplay = testReqObj.getInfo(context, "from[CSTC_TestReq2TestMethod].to.attribute[CSTC_TestReq_TestItemDisplay]");
	//System.out.println("strTestItemDisplay = " + strTestItemDisplay);

	for(int m=0;m<TestMethod.length;m++)
	{
		StringList busSel21 = new StringList();
		busSel21.addElement( DomainObject.SELECT_ID );
		StringList relSel21 = new StringList();
		relSel21.addElement( DomainRelationship.SELECT_ID );	
		MapList mplTestMethod = testReqObj.getRelatedObjects( context
				, "CSTC_TestReq2TestMethod" , "CSTC_TestMethod_Chemical"
				, busSel21, relSel21 , false , true , (short)1 , "" , "" , 0 );
				
		
				
				
		for(int j = 0;j<mplTestMethod.size();j++){
			Map MethodInfo = (Map)mplTestMethod.get(j);
			String MethodId = (String)MethodInfo.get("id");
			DomainObject methodObj = new DomainObject( MethodId );
			strItem = methodObj.getAttributeValue(context, "CSTC_TestReq_TestItem" );
			
			
			
			if(strItem.equals("Chem_Antioxidant_1")){
			    strAntioxidant = methodObj.getInfo(context, "description" );
			}else if(strItem.equals("Chem_Antioxidant_2")){
				strAntioxidant2 = methodObj.getInfo(context, "description" );
			}
			
			String[] Method = strItem.split("_");
			if(Method[1].equals("WholeChemical")){
			    strWholeChemical = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("DSCTg")){
				strDSCTg = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("DSCTm")){
				strDSCTm = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("TGA")){
				strTGA = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("S144DR")){
				strS144DR = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("GPC")){
				strGPC = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("PGC")){
				strPGC = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("GC")){
				strGC = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QA")){
				strQA = methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Deformulation")){
				strDeformulation= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Material")){
				strMaterial= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Phase")){
				strPhase= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("SBR")){
				strSBR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Microstructure")){
				strMicrostructure= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Purity")){
				strPurity= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("AP")){
				strAP= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("SWD")){
				strSWD= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("SSA")){
				strSSA= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("UDP")){
				strUPD= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QoneR")){
				strQoneR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QtwoR")){
				strQtwoR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QthreeR")){
				strQthreeR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QfourR")){
				strQfourR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("QfiveR")){
				strQfiveR= methodObj.getInfo(context, "description" );
			}else if(Method[1].equals("Other")){
				strOther= methodObj.getInfo(context, "description" );
			}

   
	        }
			
		
	}
	
	
	//Other Information
	String strRemark = testReqObj.getAttributeValue(context, "CSTC_Remark" );

	//1 Tire
	StringList busSel = new StringList();
	busSel.addElement( "id" );
	busSel.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel.addElement( "attribute[CSTC_PartNo]" );
	busSel.addElement( "attribute[CSTC_TestReq_Brand]" );
	busSel.addElement( "attribute[CSTC_TireSpec]" );
	busSel.addElement( "attribute[CSTC_TestReq_Pattern]" );
	busSel.addElement( "attribute[CSTC_TestReq_Li]" );
	busSel.addElement( "attribute[CSTC_TestReq_Si]" );
	busSel.addElement( "attribute[CSTC_ProductType]" );
	busSel.addElement( "attribute[CSTC_TestReq_Part]" );

	busSel.addElement( "attribute[CSTC_Remark]" );
	String whereStr="to[CSTC_TestReq2TestTire].from.id=='"+testReqId+"'";
	MapList dataList = DomainObject.findObjects(context, "CSTC_TestTire_Chemical" , "*", whereStr , busSel);
	
	//12 Part
	StringList busSel12 = new StringList();
	busSel12.addElement( "id" );
	busSel12.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel12.addElement( "attribute[CSTC_PartNo]" );
	busSel12.addElement( "attribute[CSTC_ProductType]" );
	busSel12.addElement( "attribute[CSTC_TestReq_Part]" );
	busSel12.addElement( "attribute[CSTC_Remark]" );
	String whereStr12="to[CSTC_TestReq2TestPart].from.id=='"+testReqId+"'";
	MapList dataList12 = DomainObject.findObjects(context, "CSTC_TestPart_Chemical" , "*", whereStr12 , busSel12);
	
	
	//2 Deformulation Result dataList2
	StringList busSel2 = new StringList();
	busSel2.addElement( "id" );
	busSel2.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel2.addElement( "attribute[CSTC_TireSpec]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Part]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_RubberType]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Proportion]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Content_Percent]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Content_PHR]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Extraction_OilWax]" );

	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_ELSE]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Carbonblack]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Ash]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_S]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_SolubleInHCL_ZnO]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_SolubleInHCL_Co]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_SolubleInHCL_Else]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_InsolubleInHCL_SiO2]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Li]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_Tg]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Specific_Gravity]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Chemical_InsolubleInHCL_CaCO3]" );
	busSel2.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr2="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList2 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Whole" , "*", whereStr2 , busSel2);
	//System.out.println("dataList2 = " + dataList2.size());


	//3 DSCTg Result dataList3
	StringList busSel3 = new StringList();
	busSel3.addElement( "id" );
	busSel3.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel3.addElement( "attribute[CSTC_TestReq_Chemical_Tg]" );
	String whereStr3="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList3 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_DSCTg" , "*", whereStr3 , busSel3);

	
	//4 DSCTm Result dataList4
	StringList busSel4 = new StringList();
	busSel4.addElement( "id" );
	busSel4.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel4.addElement( "attribute[CSTC_TestReq_Chemical_Tm]" );
	busSel4.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr4="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList4 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_DSCTm" , "*", whereStr4 , busSel4);
	//System.out.println("dataList4 = " + dataList4.size());
	
	
	//5 TGA Result dataList5
	StringList busSel5 = new StringList();
	busSel5.addElement( "id" );
	busSel5.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel5.addElement( "attribute[CSTC_TestReq_Chemical_Carbonblank]" );
	busSel5.addElement( "attribute[CSTC_TestReq_Chemical_Rubber]" );
	busSel5.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr5="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList5 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_TGA" , "*", whereStr5 , busSel5);
	
	
	//6 S144DR Result dataList6
	StringList busSel6 = new StringList();
	busSel6.addElement( "id" );
	busSel6.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel6.addElement( "attribute[CSTC_TestReq_Chemical_SB]" );
	busSel6.addElement( "attribute[CSTC_TestReq_Chemical_SA]" );
	busSel6.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr6="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList6 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_S144DR" , "*", whereStr6 , busSel6);
	
	//7 GPC Result dataList7
	StringList busSel7 = new StringList();
	busSel7.addElement( "id" );
	busSel7.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel7.addElement( "attribute[CSTC_TestReq_Chemical_Mw]" );
	busSel7.addElement( "attribute[CSTC_TestReq_Chemical_MwMn]" );
	busSel7.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr7="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList7 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_GPC" , "*", whereStr7 , busSel7);
	
	//8 PGC Result dataList8
	StringList busSel8 = new StringList();
	busSel8.addElement( "id" );
	busSel8.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel8.addElement( "attribute[CSTC_TestReq_Chemical_RubberType]" );
	busSel8.addElement( "attribute[CSTC_TestReq_Chemical_Proportion]" );
	busSel8.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr8="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList8 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_PGC" , "*", whereStr8 , busSel8);
	
	//9 GC Result dataList9
	StringList busSel9 = new StringList();
	busSel9.addElement( "id" );
	busSel9.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel9.addElement( "attribute[CSTC_TestReq_Chemical_Normal]" );
	busSel9.addElement( "attribute[CSTC_TestReq_Chemical_Unormal]" );
    busSel9.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr9="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList9 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_GC" , "*", whereStr9 , busSel9);
	
	//11 QA Result dataList11
	StringList busSel11 = new StringList();
	busSel11.addElement( "id" );
	busSel11.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel11.addElement( "attribute[CSTC_TestReq_Chemical_SixPPDP]" );
	busSel11.addElement( "attribute[CSTC_TestReq_Chemical_RDP]" );
	busSel11.addElement( "attribute[CSTC_TestReq_Chemical_SixPPD]" );
	busSel11.addElement( "attribute[CSTC_TestReq_Chemical_RD]" );
	String whereStr11="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList11 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QA" , "*", whereStr11 , busSel11);
	
	//10 Material
	StringList busSel10 = new StringList();
	busSel10.addElement( "id" );
	
	busSel10.addElement( "attribute[CSTC_TestReq_SampleId]" );
	
	busSel10.addElement( "attribute[CSTC_TestReq_Chemical_MaterialOfPLY]" );
	
	busSel10.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr10="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList10 = DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Material" , "*", whereStr10 , busSel10);
	
	//13 strAntioxidant
	StringList busSel13 = new StringList();
	busSel13.addElement( "id" );
	busSel13.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel13.addElement( "attribute[CSTC_TestReq_Chemical_SixPPD]" );
	busSel13.addElement( "attribute[CSTC_TestReq_Chemical_RD]" );
	busSel13.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr13="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList13= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_HPLC" , "*", whereStr13 , busSel13);
	
	//14 Phase Transition Temp
	StringList busSel14 = new StringList();
	busSel14.addElement( "id" );
	busSel14.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel14.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr14="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList14= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Phase" , "*", whereStr14 , busSel14);
	
	// 15 Microstructure-SBR
	StringList busSel15 = new StringList();
	busSel15.addElement( "id" );
	busSel15.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel15.addElement( "attribute[CSTC_TestReq_Chemical_Styrene]" );
	busSel15.addElement( "attribute[CSTC_TestReq_Chemical_Vinyl]" );
	busSel15.addElement( "attribute[CSTC_TestReq_Chemical_Cis]" );
	busSel15.addElement( "attribute[CSTC_TestReq_Chemical_Trans]" );
	busSel15.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr15="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList15= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_SBR" , "*", whereStr15 , busSel15);
	
	// 16 Microstructure
	StringList busSel16 = new StringList();
	busSel16.addElement( "id" );
	busSel16.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel16.addElement( "attribute[CSTC_TestReq_Chemical_Vinyl]" );
	busSel16.addElement( "attribute[CSTC_TestReq_Chemical_Cis]" );
	busSel16.addElement( "attribute[CSTC_TestReq_Chemical_Trans]" );
	busSel16.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr16="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList16= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Microstructure" , "*", whereStr16 , busSel16);
	
	// 17 Purity(%)
	StringList busSel17 = new StringList();
	busSel17.addElement( "id" );
	busSel17.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel17.addElement( "attribute[CSTC_TestReq_Chemical_Purity]" );
	busSel17.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr17="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList17= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Purity" , "*", whereStr17 , busSel17);
	
	// 18 AntioxidantPurity
	StringList busSel18= new StringList();
	busSel18.addElement( "id" );
	busSel18.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Chemical_Purity]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Chemical_Monomer]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Chemical_Dimer]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Chemical_Trimer]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Chemical_Tetramer]" );
	busSel18.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr18="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList18= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_AntioxidantPurity" , "*", whereStr18 , busSel18);
	
	// 19 Siline Weight Distribution(%)
	StringList busSel19= new StringList();
	busSel19.addElement( "id" );
	busSel19.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Chemical_Sbar]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Chemical_STwo]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Chemical_SThree]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Chemical_SFour]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Chemical_SFiveToEight]" );
	busSel19.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr19="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList19= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_SWD" , "*", whereStr19 , busSel19);
	
	// 20 Specific Surface Area
	StringList busSel20= new StringList();
	busSel20.addElement( "id" );
	busSel20.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel20.addElement( "attribute[CSTC_TestReq_Chemical_MG]" );
	busSel20.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr20="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList20= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_SSA" , "*", whereStr20 , busSel20);
	
	// 21 DPU(%)-Ply
	StringList busSel21= new StringList();
	busSel21.addElement( "id" );
	busSel21.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel21.addElement( "attribute[CSTC_TestReq_Chemical_DPU]" );
	busSel21.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr21="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList21= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_DPU" , "*", whereStr21 , busSel21);
	
		// 22 Qualitative research 1
	StringList busSel22= new StringList();
	busSel22.addElement( "id" );
	busSel22.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel22.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr22="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList22= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QoneR" , "*", whereStr22 , busSel22);
	
	// 23 Qualitative research 2
	StringList busSel23= new StringList();
	busSel23.addElement( "id" );
	busSel23.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel23.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr23="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList23= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QtwoR" , "*", whereStr23 , busSel23);
	
	// 24 Qualitative research 3
	StringList busSel24= new StringList();
	busSel24.addElement( "id" );
	busSel24.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel24.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr24="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList24= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QthreeR" , "*", whereStr24 , busSel24);
	
	// 25 Qualitative research 4
	StringList busSel25= new StringList();
	busSel25.addElement( "id" );
	busSel25.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel25.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr25="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList25= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QfourR" , "*", whereStr25 , busSel25);
	
	// 26 Qualitative research 5
	StringList busSel26= new StringList();
	busSel26.addElement( "id" );
	busSel26.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel26.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr26="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList26= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_QfiveR" , "*", whereStr26 , busSel26);
	
	// 27 Other
	StringList busSel27= new StringList();
	busSel27.addElement( "id" );
	busSel27.addElement( "attribute[CSTC_TestReq_SampleId]" );
	busSel27.addElement( "attribute[CSTC_TestReq_Remark]" );
	String whereStr27="to[CSTC_TestReq2TestResult].from.id=='"+testReqId+"'  and attribute[CSTC_TestReq_WorkCancel] !='Cancel'";
	MapList dataList27= DomainObject.findObjects(context, "CSTC_TestResult_Chemical_Other" , "*", whereStr27 , busSel27);
			   
			
	
%>
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=uft-8" />
<title>-</title>
<link rel="stylesheet" id='cssSha1' href="css/form.css" type="text/css" />
</head>
<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../cstc/scripts/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="scripts/raphael.min.js"></script>
<script language="javascript">
	function j_toexcel() { 
		bdhtml=window.document.body.innerHTML;
		sprnstr="<!--startprint-->"; 
		eprnstr="<!--endprint-->"; 
		prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); 
		prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
		if(prnhtml.search(/\S/) == -1)
		{
			alert('无资料导出，请先选择资料！')
			return false;
		}
		else
		{
			alert('提示：\n1. 此为网页版Excel\n2. 如果您想应用此Excel，请下载后，另存为Excel版本\n3. 另存时，请注意选择【文件类型】\n\n如有疑问请联系8253');
			$("body").append("<form method='post' action='http://cstcs38.cstc.com.cn/toExcel.asp' name='j_toexcel_f1' id='j_toexcel_f1'  target='_blank'></form>");
			$("#j_toexcel_f1").append("<input type='hidden' name='T_ExcelCon' value='"+escape(prnhtml)+"' id='T_ExcelCon' />");
			document.j_toexcel_f1.submit();
			$("#j_toexcel_f1").remove();
		}
	}
	
 $(document).ready(function(){
	$("#button1").bind("click",function(e){
		var currentState = '<%=currentState%>';
		var complete = "Complete";
		if( currentState ==complete){
		$("#button1").attr("disabled",true);
		$("#loadimg").show();
		
		//main code start
		$.ajax({
			url:"../cstc/CSTC_Com_HtmlToPdf.jsp",
			type:"POST",
			data:{
				u_FileName:"Chemical_SelReport_<%=testReqId%>.pdf", //pdf file name
				u_Url:"cstc/CSTC_TestReq_Chemical_SelReport.jsp?objectId=<%=testReqId%>" //print url
			},
			dataType:"JSON",
			timeout:60000,
			success:function(data){
				alert(data.resultmsg);
				
				//do something
				$("#button1").remove();
				$("#loadimg").hide();
				$("#showpdf").html("<a href=\"../../ExportFiles/Temp/Chemical_SelReport_<%=testReqId%>.pdf\" target=\"_blank\">Download PDF</a>");
				
			},
			error:function(error){
				alert('error');
			}
		});
	
		
		//main code end
		}else{
		alert("no Complete!");
	}
	
	});

});
	
</script>
<body>
<div class="main">
	<div class="form-bar2" style="text-align:right;height:20px;">
		<div id="showpdf" style="width:100px;float:right; text-align:center; "><input id="button1" name="button" type="button" value="Export PDF"></div>
       <div id="loadimg" style="width:100px;float:right; text-align:center; padding:10px; display:none"><img src="../cstc/images/loading19.gif" /></div>
	</div>
	<div class="form-div2" style="margin-top:5px;">
		<!--startprint-->

		<div class="form-header" style="width:400px;">
			<div class="form-h1">Chemical Test Report</div>
		</div>
		
		
		<div class="form-table2" style="overflow:auto; height:10px;"></div>
		<div class="form-table2" style="overflow:auto; height:25px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Project Information</div>
			<div style="float:right; width:48%; font-weight:bold; font-size:14px">Testing Requirements</div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<div style="float:left; width:49%">
				<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999">
					<tr align="center">
						<td height="60" width="20%" style="font-weight:bold;">Request Site:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strRequestSite%></td>
						<td width="20%" style="font-weight:bold;">Department:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strDeptId%></td>
					</tr>
					<tr align="center">
					    <td height="60" width="20%" style="font-weight:bold;">Request From:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strRequestFrom%></td>
						<td width="20%" style="font-weight:bold;">Project:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strPrjNm%></td>
					</tr>
					<tr align="center">
						<td height="60" width="20%" style="font-weight:bold;">Supervisor:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strSupervisor%></td>
						<td width="20%" style="font-weight:bold;">Contact Ext:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strSupervisorContactExt%></td>
					</tr>
					<tr align="center">
						<td height="62" width="20%" style="font-weight:bold;">Commissional Engineer:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strCE%></td>
						<td width="20%" style="font-weight:bold;">Contact Ext:&nbsp;</td>
						<td width="30%" align="left">&nbsp;<%=strPEContactExt%></td>
					</tr>
				</table>
			</div>
			<div style="float:right; width:49%">
				<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999">
				    <tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Request No:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Test Site:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strTestSite%></td>
					</tr>
				    <tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Required Date:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strReqDate%></td>
					</tr>
					<tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Priority Desc:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strPriority%></td>
					</tr>
				
					<tr align="center">
						<td height="60" width="40%" style="font-weight:bold;">Topic :&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strTopic%></td>
					</tr>
					
					<tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Purpose:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strPurpose%></td>
					</tr>
				
					<tr align="center">
						<td height="60" width="40%" style="font-weight:bold;">Sample Infor:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strSampleInfor%></td>
					</tr>
					
					<tr align="center">
						<td height="40" width="40%" style="font-weight:bold;">Test Item:&nbsp;</td>
						<td colspan="3" align="left">&nbsp;<%=strTestItemDisplay%></td>
					</tr>
				</table>
			</div>
		</div>
		
		
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:25px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Other Information</div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<div style="float:left; width:100%">
				<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999">
				    <tr align="center">
						<td height="50" width="300" style="font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Remartk:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td height="50" width="100%" style="font-weight:bold;" align="left">&nbsp;<%=strRemark%></td>
					</tr>
				</table>
			</div>
		</div>
		
		
		<%
			if(dataList.size()>0){
		%>
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:25px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Tire Information</div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;">Sample Id</td>
					<td style="font-weight:bold;">Part No.</td>
					<td style="font-weight:bold;">Brand</td>
					<td style="font-weight:bold;">Tire Size</td>
					<td style="font-weight:bold;">Pattern</td>
					<td style="font-weight:bold;width:6%;">LI</td>
					<td style="font-weight:bold;width:6%;">SI</td>
					<td style="font-weight:bold;">Product Type</td>
					<td style="font-weight:bold;">Part</td>
					
					<td style="font-weight:bold;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList.size();i++){
					
					Map mapItem =(Map)dataList.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem.get("attribute[CSTC_PartNo]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TestReq_Brand]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TireSpec]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TestReq_Pattern]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TestReq_Li]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TestReq_Si]")%></td>
					<td><%=mapItem.get("attribute[CSTC_ProductType]")%></td>
					<td><%=mapItem.get("attribute[CSTC_TestReq_Part]")%></td>
					
					<td><%=mapItem.get("attribute[CSTC_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
					}
		%>
		
		<%
			if(dataList12.size()>0){
		%>
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:25px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Part Information</div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;">Sample Id</td>
					<td style="font-weight:bold;">Part No.</td>
					<td style="font-weight:bold;">Product Type</td>
					<td style="font-weight:bold;">Part</td>
					<td style="font-weight:bold;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList12.size();i++){
					
					Map mapItem12 =(Map)dataList12.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem12.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem12.get("attribute[CSTC_PartNo]")%></td>
					<td><%=mapItem12.get("attribute[CSTC_ProductType]")%></td>
					<td><%=mapItem12.get("attribute[CSTC_TestReq_Part]")%></td>
					<td><%=mapItem12.get("attribute[CSTC_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		
		
		
		
		<%
			if(dataList2.size()>0){
		%>
		<!--Test Result Chemical Analysis -->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Chemical Analysis</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strDeformulation%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td rowspan="2" style="font-weight:bold;width:11%;">ID</td>
					<td rowspan="2" style="font-weight:bold;width:6%;">Rubber type</td>
					<td rowspan="2" style="font-weight:bold;width:6%;">Proportion</td>
					
					<td height="20" colspan="2" style="font-weight:bold;width:12%;">Rubber</td>
					
					<td height="20" colspan="2" style="font-weight:bold;width:16%;">Extraction</td>
					
					<td rowspan="2" style="font-weight:bold;width:5%;">Carbon  black</td>
					<td rowspan="2" style="font-weight:bold;width:5%;">S</br>PHR</td>
					<td rowspan="2" style="font-weight:bold;width:5%;">Ash</br>PHR</td>
						
					<td height="20" colspan="5" style="font-weight:bold;width:12%;">Content of Ash</td>
					
					<td rowspan="2" style="font-weight:bold;width:6%;">Li(ppm)</td>
					<td rowspan="2" style="font-weight:bold;width:6%;">Tg(℃)</td>
					<td rowspan="2" style="font-weight:bold;width:6%;">specific gravity</td>
					<td rowspan="2" style="font-weight:bold;width:6%;">remark</td>
				</tr>
				<tr align="center">
					<td height="20" style="font-weight:bold;width:6%;">%</td>
				    <td style="font-weight:bold;width:6%;">PHR</td>
					
				    <td style="font-weight:bold;width:4%;">Oil+Wax </br> aliphatic resin </br>PHR</td>
					<td style="font-weight:bold;width:4%;">ELSE</br>PHR</td>
					
				    <td style="font-weight:bold;width:4%;">ZnO</br>PHR</td>
				    <td style="font-weight:bold;width:4%;">Co</br>PHR</td>
					<td style="font-weight:bold;width:4%;">CaCO3</br>PHR</td>
					<td style="font-weight:bold;width:10%;">SiO2</br>PHR</td>
				    <td style="font-weight:bold;width:4%;">Else</br>PHR</td>
					
				</tr>
				
				<%
					for(int i = 0; i < dataList2.size();i++){
					
					Map mapItem2 =(Map)dataList2.get(i);
				%>
				<tr align="center">
				
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_SampleId]"))){ %>
                    	<td height="20"><%=mapItem2.get("attribute[CSTC_TestReq_SampleId]")%></td>
                      <% } else { %>
                    <td height="20">-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_RubberType]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_RubberType]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
	
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Proportion]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Proportion]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
			
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Content_Percent]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Content_Percent]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Content_PHR]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Content_PHR]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Extraction_OilWax]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Extraction_OilWax]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
				
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_ELSE]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_ELSE]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Carbonblack]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Carbonblack]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
						<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_S]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_S]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Ash]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Ash]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
				
				
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_ZnO]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_ZnO]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_Co]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_Co]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_InsolubleInHCL_CaCO3]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_InsolubleInHCL_CaCO3]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
						<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_InsolubleInHCL_SiO2]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_InsolubleInHCL_SiO2]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_Else]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_SolubleInHCL_Else]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
				
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Li]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Li]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Chemical_Tg]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Chemical_Tg]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
										<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Specific_Gravity]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Specific_Gravity]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					<%  if(!"".equals(mapItem2.get("attribute[CSTC_TestReq_Remark]"))){ %>
                    	<td><%=mapItem2.get("attribute[CSTC_TestReq_Remark]")%></td>
                      <% } else { %>
                    <td >-</td>
                    <% } %>
					
					
					
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		<%
			if(dataList10.size()>0){
		%>
		<!--Test Result Mterial-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Material of PLY</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strMaterial%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
				    <td style="font-weight:bold;width:10%;">Sample Id</td>
					
					
				    
					<td style="font-weight:bold;width:15%;">Mterial OF  PLY</td>
					
					<td style="font-weight:bold;width:15%;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList10.size();i++){
					
					Map mapItem10 =(Map)dataList10.get(i);
				%>
				<tr align="center">
				    	<%  if(!"".equals(mapItem10.get("attribute[CSTC_TestReq_SampleId]"))){ %>
                    	<td height="20"><%=mapItem10.get("attribute[CSTC_TestReq_SampleId]")%></td>
                      <% } else { %>
                    <td height="20">-</td>
                       <% } %>
					 
					<td><%=mapItem10.get("attribute[CSTC_TestReq_Chemical_MaterialOfPLY]")%></td>
					
					<td><%=mapItem10.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		<%
			if(dataList3.size()>0){
		%>
		<!--Test Result DSC-Tg-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result DSC-Tg</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strDSCTg%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td style="font-weight:bold;width:50%;">Sample Id</td>
					<td style="font-weight:bold;width:50%;">Tg(℃)</td>
				</tr>
				<%
					for(int i = 0; i < dataList3.size();i++){
					
					Map mapItem3 =(Map)dataList3.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem3.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem3.get("attribute[CSTC_TestReq_Chemical_Tg]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList4.size()>0){
		%>
		<!--Test Result DSC-Tm-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Melting Point(℃)</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strDSCTm%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:30%;">Tm(℃)</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
				<%
					for(int i = 0; i < dataList4.size();i++){
					Map mapItem4 =(Map)dataList4.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem4.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem4.get("attribute[CSTC_TestReq_Chemical_Tm]")%></td>
					<td><%=mapItem4.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList5.size()>0){
		%>
		<!--Test Result TGA-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Carbon black(%)</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strTGA%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">Carbon black(%)</td>
					<td style="font-weight:bold;width:25%;">ASH(%)</td>
					<td style="font-weight:bold;width:25%;">remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList5.size();i++){
					
					Map mapItem5 =(Map)dataList5.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem5.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem5.get("attribute[CSTC_TestReq_Chemical_Carbonblank]")%></td>
					<td><%=mapItem5.get("attribute[CSTC_TestReq_Chemical_Rubber]")%></td>
					<td><%=mapItem5.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList6.size()>0){
		%>
		<!--Test Result S-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Polymer Analysis</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strS144DR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:33%;">Sample Id</td>
					<td style="font-weight:bold;width:33%;">S(%)</td>
					<td style="font-weight:bold;width:34%;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList6.size();i++){
					
					Map mapItem6 =(Map)dataList6.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem6.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem6.get("attribute[CSTC_TestReq_Chemical_SB]")%></td>
					<td><%=mapItem6.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList7.size()>0){
		%>
		<!--Test Result GPC-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result GPC</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strGPC%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
				    <td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">Mw(g/mol)</td>
					<td style="font-weight:bold;width:25%;">Mw/Mn</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList7.size();i++){
					
					Map mapItem7 =(Map)dataList7.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem7.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem7.get("attribute[CSTC_TestReq_Chemical_Mw]")%></td>
					<td><%=mapItem7.get("attribute[CSTC_TestReq_Chemical_MwMn]")%></td>
					<td><%=mapItem7.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		<%
			if(dataList8.size()>0){
		%>
		<!--Test Result PGC-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result PGC</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strPGC%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">Rubber type</td>
					<td style="font-weight:bold;width:25%;">Proportion</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList8.size();i++){
					
					Map mapItem8 =(Map)dataList8.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem8.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem8.get("attribute[CSTC_TestReq_Chemical_RubberType]")%></td>
					<td><%=mapItem8.get("attribute[CSTC_TestReq_Chemical_Proportion]")%></td>
					<td><%=mapItem8.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList9.size()>0){
		%>
		<!--Test Result GC-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Carbon number Distribution-WAX</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strGC%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">Normal</td>
					<td style="font-weight:bold;width:25%;">Iso</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
				</tr>
				<%
					for(int i = 0; i < dataList9.size();i++){
					
					Map mapItem9 =(Map)dataList9.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem9.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem9.get("attribute[CSTC_TestReq_Chemical_Normal]")%></td>
					<td><%=mapItem9.get("attribute[CSTC_TestReq_Chemical_Unormal]")%></td>
					<td><%=mapItem9.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList11.size()>0){
		%>
		<!--Test Result QA-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Antioxidant</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQA%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:20%;">Sample Id</td>
					<td style="font-weight:bold;width:20%;">6PPD%</td>
					<td style="font-weight:bold;width:20%;">RD%</td>
					<td style="font-weight:bold;width:20%;">6PPD(PHR)</td>
					<td style="font-weight:bold;width:20%;">RD(PHR)</td>
				</tr>
				<%
					for(int i = 0; i < dataList11.size();i++){
					
					Map mapItem11 =(Map)dataList11.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem11.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem11.get("attribute[CSTC_TestReq_Chemical_SixPPDP]")%></td>
					<td><%=mapItem11.get("attribute[CSTC_TestReq_Chemical_RDP]")%></td>
					<td><%=mapItem11.get("attribute[CSTC_TestReq_Chemical_SixPPD]")%></td>
					<td><%=mapItem11.get("attribute[CSTC_TestReq_Chemical_RD]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
		
		 for(int m=0;m<TestMethod.length;m++)  {
		    if(TestMethod[m].equals("Chem_Antioxidant_1")){		
			if(dataList13.size()>0){
		%>
		<!--Test Result QA-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result  Antioxidant</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strAntioxidant%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">6PPD%</td>
					<td style="font-weight:bold;width:25%;">RD%</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList13.size();i++){
					
					Map mapItem13 =(Map)dataList13.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem13.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Chemical_SixPPD]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Chemical_RD]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}

			    
				%>
			</table>
		</div>
		<%
			}
		  }
		  }
		 
		%>
		
		
		
		<%
		
		 for(int m=0;m<TestMethod.length;m++)  {
		    if(TestMethod[m].equals("Chem_Antioxidant_2")){		
			if(dataList13.size()>0){
		%>
		<!--Test Result QA-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result  Antioxidant</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strAntioxidant2%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:25%;">Sample Id</td>
					<td style="font-weight:bold;width:25%;">6PPD(PHR)</td>
					<td style="font-weight:bold;width:25%;">RD(PHR)</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList13.size();i++){
					
					Map mapItem13 =(Map)dataList13.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem13.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Chemical_SixPPD]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Chemical_RD]")%></td>
					<td><%=mapItem13.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}

			    
				%>
			</table>
		</div>
		<%
			}
		  }
		  }
		 
		%>
		
		
		
		
		<%
			if(dataList14.size()>0){
		%>
		<!--Test Result Phase Transition Temp-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Phase Transition Temp</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strPhase%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:50%;">Sample Id</td>
					<td style="font-weight:bold;width:50%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList14.size();i++){
					
					Map mapItem14 =(Map)dataList14.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem14.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem14.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		<%
			if(dataList15.size()>0){
		%>
		<!--Test Result Microstructure-SBR-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Microstructure-SBR</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strSBR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:15%;">Sample Id</td>
					<td style="font-weight:bold;width:15%;">Styrene%</td>
					<td style="font-weight:bold;width:15%;">Vinyl%</td>
					<td style="font-weight:bold;width:15%;">Cis%</td>
					<td style="font-weight:bold;width:15%;">Trans%</td>
					<td style="font-weight:bold;width:25%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList15.size();i++){
					
					Map mapItem15 =(Map)dataList15.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem15.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem15.get("attribute[CSTC_TestReq_Chemical_Styrene]")%></td>
					<td><%=mapItem15.get("attribute[CSTC_TestReq_Chemical_Vinyl]")%></td>
					<td><%=mapItem15.get("attribute[CSTC_TestReq_Chemical_Cis]")%></td>
					<td><%=mapItem15.get("attribute[CSTC_TestReq_Chemical_Trans]")%></td>
					<td><%=mapItem15.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		
		<%
			if(dataList16.size()>0){
		%>
		<!--Test Result Microstructure-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Microstructure-BR</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strMicrostructure%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:20%;">Sample Id</td>
					<td style="font-weight:bold;width:20%;">Vinyl%</td>
					<td style="font-weight:bold;width:20%;">Cis%</td>
					<td style="font-weight:bold;width:20%;">Trans%</td>
					<td style="font-weight:bold;width:20%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList16.size();i++){
					
					Map mapItem16 =(Map)dataList16.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem16.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem16.get("attribute[CSTC_TestReq_Chemical_Vinyl]")%></td>
					<td><%=mapItem16.get("attribute[CSTC_TestReq_Chemical_Cis]")%></td>
					<td><%=mapItem16.get("attribute[CSTC_TestReq_Chemical_Trans]")%></td>
					<td><%=mapItem16.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		<%
			if(dataList17.size()>0){
		%>
		<!--Test Result Purity  -->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Purity(%)</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp; <%=strPurity%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:30%;">Purity(%)</td>
					<td style="font-weight:bold;width:35%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList17.size();i++){
					
					Map mapItem17 =(Map)dataList17.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem17.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem17.get("attribute[CSTC_TestReq_Chemical_Purity]")%></td>
					<td><%=mapItem17.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>
		
		<%
			if(dataList18.size()>0){
		%>
		<!--Test Result AntioxidantPurity-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test ResultAntioxidant Purity(%)</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strAP%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:10%;">Sample Id</td>
					<td style="font-weight:bold;width:15%;">Purity%</td>
					<td style="font-weight:bold;width:15%;">单体%</td>
					<td style="font-weight:bold;width:15%;">二聚体%</td>
					<td style="font-weight:bold;width:15%;">三聚体%</td>
					<td style="font-weight:bold;width:15%;">四聚体%</td>
					<td style="font-weight:bold;width:15%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList18.size();i++){
					
					Map mapItem18 =(Map)dataList18.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem18.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Chemical_Purity]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Chemical_Monomer]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Chemical_Dimer]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Chemical_Trimer]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Chemical_Tetramer]")%></td>
					<td><%=mapItem18.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList19.size()>0){
		%>
		<!--Test Result Siline Weight Distribution(%)-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test ResultAntioxidant Siline Weight Distribution(%)</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strSWD%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:10%;">Sample Id</td>
					<td style="font-weight:bold;width:15%;">Purity%</td>
					<td style="font-weight:bold;width:15%;">S2%</td>
					<td style="font-weight:bold;width:15%;">S3%</td>
					<td style="font-weight:bold;width:15%;">S4%</td>
					<td style="font-weight:bold;width:15%;">S5~S8%</td>
					<td style="font-weight:bold;width:15%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList19.size();i++){
					
					Map mapItem19 =(Map)dataList19.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem19.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Chemical_Sbar]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Chemical_STwo]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Chemical_SThree]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Chemical_SFour]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Chemical_SFiveToEight]")%></td>
					<td><%=mapItem19.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList20.size()>0){
		%>
		<!--Test ResultSpecific Surface Area-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Specific Surface Area</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strSSA%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:30%;">m2/g</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList20.size();i++){
					
					Map mapItem20 =(Map)dataList20.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem20.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem20.get("attribute[CSTC_TestReq_Chemical_MG]")%></td>
					<td><%=mapItem20.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList21.size()>0){
		%>
		<!--Test Result DPU(%)-Ply-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result DPU(%)-Ply</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strUPD%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:30%;">UDP(%)</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList21.size();i++){
					
					Map mapItem21 =(Map)dataList21.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem21.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem21.get("attribute[CSTC_TestReq_Chemical_DPU]")%></td>
					<td><%=mapItem21.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList22.size()>0){
		%>
		<!--Test Result Qualitative Research 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Research</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQoneR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList22.size();i++){
					
					Map mapItem22 =(Map)dataList22.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem22.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem22.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		<%
			if(dataList23.size()>0){
		%>
		<!--Test Result Qualitative Research 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Research</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQtwoR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList23.size();i++){
					
					Map mapItem23 =(Map)dataList23.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem23.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem23.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList24.size()>0){
		%>
		<!--Test Result Qualitative Research 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Research</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQthreeR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList24.size();i++){
					
					Map mapItem24 =(Map)dataList24.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem24.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem24.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList25.size()>0){
		%>
		<!--Test Result Qualitative Research 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Research</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQfourR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList25.size();i++){
					
					Map mapItem25 =(Map)dataList25.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem25.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem25.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		<%
			if(dataList26.size()>0){
		%>
		<!--Test Result Qualitative Research 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Qualitative Research</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strQfiveR%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList26.size();i++){
					
					Map mapItem26 =(Map)dataList26.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem26.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem26.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
		%>
		
		
		<%
			if(dataList27.size()>0){
		%>
		<!--Test Result Other 1-->
		<div class="form-table2" style="overflow:auto; height:8px;"></div>
		<div class="form-table2" style="overflow:auto; height:50px;">
			<div style="float:left; width:49%; font-weight:bold; font-size:14px">Test Result Other</div>
			<div style="clear:both;"></div>
			<div style="float:left; font-size:14px"><b>Test Method:</b>&nbsp;<%=strOther%></div>
		</div>
		<div class="form-table2" style="overflow:auto;">
			<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="#999999" width="100%">
				<tr align="center">
					<td height="20" style="font-weight:bold;width:30%;">Sample Id</td>
					<td style="font-weight:bold;width:40%;">Remark</td>
					
				</tr>
				<%
					for(int i = 0; i < dataList27.size();i++){
					
					Map mapItem27 =(Map)dataList27.get(i);
				%>
				<tr align="center">
					<td height="20"><%=mapItem27.get("attribute[CSTC_TestReq_SampleId]")%></td>
					<td><%=mapItem27.get("attribute[CSTC_TestReq_Remark]")%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<%
			}
   
   
		%>
  
 
		<!--endprint-->
	</div>
</div>
</body>
</html>
<%@include file="../common/emxNavigatorBottomErrorInclude.inc"%>
