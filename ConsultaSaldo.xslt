<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="1.0" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
        xmlns:rtbs="http://comverse-in.com/prepaid/ccws"
        xmlns:java="http://xml.apache.org/xslt/java"
    xmlns:cal="java.util.Calendar"
    xmlns:sf="java.text.SimpleDateFormat"
    exclude-result-prefixes="java">
        <!-- Version transformacion RTBS -->
        <xsl:output method="text" />
        <!-- CONSTANTS -->

        <xsl:variable name="coreBName" select="'Core'" />
        <xsl:variable name="textPlan" select="' Plan '" />
        <xsl:variable name="puntoSeparador" select="'. '" />
        <xsl:variable name="punto" select="'.'" />
        <xsl:variable name="espacioSeparador" select="' '" />
        <xsl:variable name="textSaldo" select="'Bs'" />
        <!-- <xsl:variable name="textFecha" select="' que bloquea el '" /> -->
		
        <xsl:variable name="textBonos" select="'mas Bs'" />
        <xsl:variable name="textSeg412" select="' Seg Dig:'" />
        <xsl:variable name="textSegTodas" select="' Seg Todas:'" />
        <xsl:variable name="textSegOtras" select="' Seg Otras:'" />
        <xsl:variable name="textMin412" select="' Min Dig:'" />
        <xsl:variable name="textMinTodas" select="' Min Todas:'" />
        <xsl:variable name="textMinOtras" select="' Min Otras:'" />
        <xsl:variable name="textMMS" select="' MMS:'" />
        <xsl:variable name="textMB" select="' MB:'" />	
        <xsl:variable name="textCorte" select="'. Recuerde recargar antes de su fecha de pago los '" />
        <xsl:variable name="textCorte2" select="' de cada mes.'" />
		<xsl:variable name="textSMS" select="' SMS:'" />
		<xsl:variable name="textSegAmigo" select="' Seg Amigo:'" />
		<xsl:variable name="textMinAmigo" select="' Min Amigo:'" />
		
		<xsl:variable name="mensajePreactiva" select="'Linea sin datos personales. Para hacer uso del servicio Ud. debe dirigirse al Agente o Centro de Atencion donde la compro para su registro'" />

		<xsl:variable name="mensajePlanAnulacion" select="'Disculpe, su solicitud no procede esta linea esta anulada.'" />
		
        <!-- EQUIVALENCIA DE ESTADO DE LINEA -->
        <xsl:variable name="idleStateRTBS" select="'Idle'" />
        <xsl:variable name="activeStateRTBS" select="'Active'" />
        <!-- <xsl:variable name="awaitStateRTBS" select="'Await Activation'" /> -->
        <!-- <xsl:variable name="await1StateRTBS" select="'Await 1 st Activation'" /> -->
        <xsl:variable name="suspendesS1StateRTBS" select="'Suspended(S1)'" />
        <xsl:variable name="stolenS2StateRTBS" select="'Stolen(S2)'" />
        <!-- <xsl:variable name="suspendesS3StateRTBS" select="'Suspended(S3)'" /> -->
        <!-- <xsl:variable name="suspendesS4StateRTBS" select="'Suspended(S4)'" /> -->
        <xsl:variable name="fraudLockoutStateRTBS" select="'Fraud Lockout'" />

        <xsl:variable name="idleStateGeneric" select="'Pre-Activo'" />
        <xsl:variable name="activeStateGeneric" select="'Activo'" />
        <!-- <xsl:variable name="awaitStateGeneric" select="''" /> -->
        <!-- <xsl:variable name="await1StateGeneric" select="''" /> -->
        <xsl:variable name="suspendesS1StateGeneric"
                select="'Suspendido'" />
        <xsl:variable name="stolenS2StateGeneric"
                select="'Suspendido'" />
        <!-- <xsl:variable name="suspendesS3StateGeneric" select="''" /> -->
        <!-- <xsl:variable name="suspendesS4StateGeneric" select="''" /> -->
        <xsl:variable name="fraudLockoutStateGeneric" select="'Suspendido'" />

        <xsl:decimal-format name="espaniol" decimal-separator=","
                grouping-separator="." />

        <xsl:variable name="ProxCobroMensaj" select="'Prox Pago'" />
        <xsl:variable name="separadorMESdia" select="'-'" />
		
		<xsl:template match="/">
		<xsl:variable name="Core_C" select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='Core']/rtbs:Balance"/>
		
		<xsl:variable name="NF_SMS_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='NF_SMS']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>
		<xsl:variable name="NF_SMS_PREMIUM_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='NF_SMS_PREMIUM']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>
		<xsl:variable name="F_SMS_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_SMS']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>
		<xsl:variable name="F_SMS_PREMIUM_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_SMS_PREMIUM']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>
		<xsl:variable name="NF_MMS_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='NF_MMS']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>
		<xsl:variable name="F_MMS_C">
            <xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_MMS']/rtbs:Balance)"/>
            </xsl:call-template>
        </xsl:variable>	
   

                <!-- ESTADO -->
				<xsl:variable name="FacCall"  select="//INFO_DATA/@CallFactor" />
				<xsl:variable name="isNextCharge"  select="//INFO_DATA/@isNextCharge" />
				<xsl:variable name="nextChargeDate"  select="//INFO_DATA/@nextChargeDate" />
				
				
				
                <xsl:variable name="ESTADO" select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:CurrentState" />

                <xsl:variable name="Corte" select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:BillCycleDay" />
			
                	
				<!-- SALDO -->
				<!-- 18/05/2016 GH: Se agrega llamado a la plantilla "isNaN" para evaluar si en el balance Main existe un valor NaN -->
                <xsl:variable name="BS">
				<xsl:call-template name="isNaN">
					<xsl:with-param name="doubleIn" select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName=$coreBName]/rtbs:Balance)"/>
				</xsl:call-template>
				</xsl:variable>
				

                <!-- BONO -->
                <xsl:variable name="BONO"
                        select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_BS']/rtbs:Balance)" />

                <!-- SEGUNDOS 412 -->
                <xsl:variable name="SEC_412"
                        select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_SEC_F2MF_ON-NET'  or  rtbs:BalanceName='F_SEC_F2M_ON-NET'  or  rtbs:BalanceName='F_SEC_M2MF_ON-NET'  or  rtbs:BalanceName='NF_SEC_F2M_ON-NET'  or  rtbs:BalanceName='NF_SEC_M2MF_ON-NET'  or  rtbs:BalanceName='F_SEC_F2F_N-W'  or  rtbs:BalanceName='F_SEC_M2MF_N-W'  or  rtbs:BalanceName='NF_SEC_F2F_N-W'  or  rtbs:BalanceName='NF_SEC_M2MF_N-W']/rtbs:Balance)" />


            <!-- MINUTOS 412 -->
			<xsl:variable name="MIN_412">
			<xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="($SEC_412 div 60.0)"/>
            </xsl:call-template>
			</xsl:variable>
               

                <!-- SEGUNDOS OTRAS -->
                <xsl:variable name="SEC_OTRAS"
                        select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_SEC_F2MF_OFF-NET' or rtbs:BalanceName='F_SEC_M2MF_OFF-NET' or rtbs:BalanceName='NF_SEC_M2MF_OFF-NET' or rtbs:BalanceName='F_SEC_F_LDI' or rtbs:BalanceName='NF_SEC_F_LDI' or rtbs:BalanceName='NF_SEC_LDI']/rtbs:Balance)" />

                <!-- MINUTOS OTRAS -->
		    <xsl:variable name="MIN_OTRAS">
			<xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="($SEC_OTRAS div 60.0)"/>
            </xsl:call-template>
			</xsl:variable>


                <!-- SEGUNDOS TODAS -->
                <xsl:variable name="SEC_TODAS"
                        select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='NF_SEC_M2MF_ON-OFF-NET'  or rtbs:BalanceName='F_SEC_M2MF_ON-OFF-NET'  or rtbs:BalanceName='NF_SEC_F2F_LDN_ON-OFF-NET_N-W'  or rtbs:BalanceName='NF_SEC_F2M_ON-OFF-NET'  or rtbs:BalanceName='NF_SEC_F2F_LOC_ON-OFF-NET'  or rtbs:BalanceName='NF_SEC_F2F_LOC_ON-OFF-NET_N-W'  or rtbs:BalanceName='F_SEC_F2M_ON-OFF-NET'  or rtbs:BalanceName='F_SEC_F2F_LOC_ON-OFF-NET'  or rtbs:BalanceName='F_SEC_F2F_LOC_ON-OFF-NET_N-W'  or rtbs:BalanceName='F_SEC_F2F_LDN_ON-OFF-NET_N-W'  or rtbs:BalanceName='NF_SEC_F2MF_ON-OFF-NET'  or rtbs:BalanceName='F_SEC_F2MF_ON-OFF-NET' ]/rtbs:Balance)" />

                <!-- MINUTOS TODAS -->
		    <xsl:variable name="MIN_TODAS">
			<xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="($SEC_TODAS div 60.0)"/>
            </xsl:call-template>
			</xsl:variable>
			
             <!-- SEGUNDOS AMIGO -->
                <xsl:variable name="SEC_AMIGO"
						select="sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='NF_SEC_FF']/rtbs:Balance)" />
									 
                <!-- MINUTOS AMIGO -->
		    <xsl:variable name="MIN_AMIGO">
			<xsl:call-template name="replaceDecimal">
              <xsl:with-param name="stringIn" select="($SEC_AMIGO div 60.0)"/>
            </xsl:call-template>
			</xsl:variable>


                <!-- MMS -->
                <xsl:variable name="MMS"
                        select="($NF_MMS_C+$F_MMS_C)" />

                <!-- MB -->
                <xsl:variable name="MB"
                        select="(sum(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName='F_KB' or rtbs:BalanceName='NF_KB']/rtbs:Balance)) div 1024" />

                <!-- SMS -->
                <xsl:variable name="SMS"
                        select="($NF_SMS_C+ $NF_SMS_PREMIUM_C +$F_SMS_C+$F_SMS_PREMIUM_C)" />

                <xsl:variable name="ExpiryDate"
                        select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:Balances/rtbs:Balance[rtbs:BalanceName=$coreBName]/rtbs:AccountExpiration" />



                <!-- *************************************************************************************************** -->
                
				
				
				<!-- MENSAJE RETORNADO -->
				
				
				
				<xsl:if test="$FacCall != 999 and $FacCall != 998">
				

                <xsl:value-of select="$textSaldo" />
                <xsl:value-of select="$espacioSeparador" />
                <xsl:value-of
                        select="format-number($BS,'########0,00','espaniol')" />
                <xsl:value-of select="$espacioSeparador" />

                <xsl:choose>
                        <xsl:when test="$ESTADO = $idleStateRTBS">
                                <xsl:value-of select="$idleStateGeneric" />
                                <!-- <xsl:value-of select="$puntoSeparador" /> -->
                        </xsl:when>
                        <xsl:when test="$ESTADO = $activeStateRTBS">
                                <xsl:value-of select="$activeStateGeneric" />
                                <!-- <xsl:value-of select="$puntoSeparador" /> -->
                        </xsl:when>
                        <xsl:when test="$ESTADO = $suspendesS1StateRTBS">
                                <xsl:value-of select="$suspendesS1StateGeneric" />
                                <!-- <xsl:value-of select="$puntoSeparador" /> -->
                        </xsl:when>
                        <xsl:when test="$ESTADO = $stolenS2StateRTBS">
                                <xsl:value-of select="$stolenS2StateGeneric" />
                                <!-- <xsl:value-of select="$puntoSeparador" /> -->
                        </xsl:when>
                        <xsl:when test="$ESTADO = $fraudLockoutStateRTBS">
                                <xsl:value-of select="$fraudLockoutStateGeneric" />
                                <!-- <xsl:value-of select="$puntoSeparador" /> -->
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="''" />
                        </xsl:otherwise>
                </xsl:choose>



                <!-- <xsl:if test="(substring($ExpiryDate,1,4) != '0001') and $BS != 0">
                                             <xsl:value-of select="$textFecha" />
                        <xsl:variable name="day"
                        select="substring($ExpiryDate,9,2)" />
                        <xsl:variable name="month"
                        select="substring($ExpiryDate,6,2)" />
                        <xsl:variable name="year"
                        select="substring($ExpiryDate,3,2)" />
                        <xsl:value-of select="concat($day,'/',$month,'/',$year)" />
                        </xsl:if> -->

                <!--<xsl:if test="$BONO = 0">
                                             <xsl:value-of select="$puntoSeparador" />
                        </xsl:if> -->

                <!-- <xsl:if
                                             test="$BONO + $SEC_412 + $SEC_OTRAS + $SEC_TODAS + $MMS + $MB + $SMS &gt; 0">
                        <xsl:value-of select="$espacioSeparador" />
                        </xsl:if> -->

                <xsl:if test="$BONO &gt; 0">
                        <xsl:value-of select="$espacioSeparador" />
                        <xsl:value-of select="$textBonos" />
                        <xsl:value-of select="$espacioSeparador" />
                        <xsl:value-of
                                select="format-number($BONO,'########0,00','espaniol')" />
                        <!-- <xsl:value-of select="$puntoSeparador" />  -->
                </xsl:if>
				
				<xsl:variable name="CosNameAmigo" select="string(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName)" />
									
                <xsl:choose>
                        <xsl:when       test="$FacCall &lt; 60" >
                        <xsl:if test="$SEC_412 &gt; 0">
                                        <xsl:value-of select="$textSeg412" />
                                        <xsl:value-of
                                                select="format-number($SEC_412,'####','espaniol')" />
                                </xsl:if>
                                <xsl:if test="$SEC_OTRAS &gt; 0">
                                        <xsl:value-of select="$textSegOtras" />
                                        <xsl:value-of
                                                select="format-number($SEC_OTRAS,'####','espaniol')" />
                                </xsl:if>
                                <xsl:if test="$SEC_TODAS &gt; 0">
                                        <xsl:value-of select="$textSegTodas" />
                                        <xsl:value-of
                                                select="format-number($SEC_TODAS,'####','espaniol')" />
                                </xsl:if>
								<xsl:if test="contains($CosNameAmigo, 'Super Pegado Plus') or contains($CosNameAmigo, 'Inteligente')">
									<xsl:if test="$SEC_AMIGO &gt; 0"> 
                                        <xsl:value-of select="$textSegAmigo" />
                                        <xsl:value-of select="format-number($SEC_AMIGO,'####','espaniol')" />
									</xsl:if>
								</xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:if test="$MIN_412 >= 1">
                                        <xsl:value-of select="$textMin412" />
                                        <xsl:value-of
                                                select="format-number($MIN_412,'####','espaniol')" />
                                </xsl:if>
                                <xsl:if test="$MIN_OTRAS >= 1">
                                        <xsl:value-of select="$textMinOtras" />
                                        <xsl:value-of
                                                select="format-number($MIN_OTRAS,'####','espaniol')" />
                                </xsl:if>

                                <xsl:if test="$MIN_TODAS >= 1">
                                        <xsl:value-of select="$textMinTodas" />
                                        <xsl:value-of
                                                select="format-number($MIN_TODAS,'####','espaniol')" />
                                </xsl:if>
								<xsl:if test="contains($CosNameAmigo, 'Super Pegado Plus') or contains($CosNameAmigo, 'Inteligente')">
									<xsl:if test="$MIN_AMIGO &gt; 0"> 
                                        <xsl:value-of select="$textMinAmigo" />
                                        <xsl:value-of select="format-number($MIN_AMIGO,'####','espaniol')" />
									</xsl:if>
								</xsl:if>
                        </xsl:otherwise>
                </xsl:choose>

                <xsl:if test="$SMS &gt; 0">
                        <xsl:value-of select="$textSMS" />
                        <xsl:value-of
                                select="format-number($SMS,'####','espaniol')" />
                </xsl:if>

                <!-- <xsl:if test="$SMS &gt; 0 and $MB &gt; 0">
                                             <xsl:value-of select="$puntoSeparador" />
                        </xsl:if>  -->

                <xsl:if test="$MB &gt; 0">
                        <xsl:value-of select="$textMB" />
                        <xsl:value-of
                                select="format-number($MB,'########','espaniol')" />
                </xsl:if>

                <!-- <xsl:if test="$MB &gt; 0 and $MMS &gt; 0">
                                             <xsl:value-of select="$puntoSeparador" />
                        </xsl:if>  -->

                <xsl:if test="not(contains($CosNameAmigo, 'Super Pegado Plus')) and not(contains($CosNameAmigo, 'Inteligente'))">
					<xsl:if test="$MMS &gt; 0">
							<xsl:value-of select="$textMMS" />
							<xsl:value-of
									select="format-number($MMS,'####','espaniol')" />
					</xsl:if>
				</xsl:if>

                <!-- <xsl:if
                                             test="$SEC_412 + $SEC_OTRAS + $SEC_TODAS + $MMS + $MB + $SMS &gt; 0">
                        <xsl:value-of select="$puntoSeparador" />
                        </xsl:if>  -->

                <!-- <xsl:value-of select="$puntoSeparador" /> -->

                
<!--            espacioSeparador
                                <xsl:choose>
                        <xsl:when test="contains(rtbs:COSName,'ZF')">
                                <xsl:variable name="myNewString2" select="substring-before(rtbs:COSName,' ZF')" />
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:variable name="myNewString2"
                                        select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName)" />
                        </xsl:otherwise>
                </xsl:choose>-->

                


				

<xsl:value-of select="$espacioSeparador" />
  <xsl:choose>
        <xsl:when test="contains(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName,' ZF')">
			<xsl:variable name="NewCosName">
				<xsl:call-template name="replaceCharsInString">
				  <xsl:with-param name="stringIn" select="string(substring-before(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName,' ZF'))"/>
				  <xsl:with-param name="charsIn" select="' '"/>
				  <xsl:with-param name="charsOut" select="''"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$NewCosName" />
		</xsl:when>
        <xsl:when test="contains(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName,'ZF')">
			<xsl:variable name="NewCosName">
				<xsl:call-template name="replaceCharsInString">
				  <xsl:with-param name="stringIn" select="string(substring-before(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName,'ZF'))"/>
				  <xsl:with-param name="charsIn" select="' '"/>
				  <xsl:with-param name="charsOut" select="''"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$NewCosName" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="NewCosName">
				<xsl:call-template name="replaceCharsInString">
				  <xsl:with-param name="stringIn" select="string(//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:SubscriberData/rtbs:COSName)"/>
				  <xsl:with-param name="charsIn" select="' '"/>
				  <xsl:with-param name="charsOut" select="''"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$NewCosName" />
         </xsl:otherwise>
        </xsl:choose>


        <xsl:value-of select="$textCorte" />
        <xsl:value-of
                        select="$Corte" />
        <xsl:value-of select="$textCorte2" />
				
				
				<xsl:variable name="FIRST_CHARGE"
select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:PeriodicCharges/rtbs:PeriodicCharge[rtbs:ApplyDay &gt; 0 ]/rtbs:FirstChargeApplied"/>

<xsl:variable name="APPLAYday"
select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:PeriodicCharges/rtbs:PeriodicCharge[rtbs:ApplyDay &gt; 0 ]/rtbs:ApplyDay"/>

<xsl:variable name="startDATE"
select="//rtbs:RetrieveSubscriberWithIdentityNoHistoryResult/rtbs:PeriodicCharges/rtbs:PeriodicCharge[rtbs:ApplyDay &gt; 0 ]/rtbs:StartDate"/>








						<!--<xsl:if  test="(($isNextCharge = 'true'))">
						     							<xsl:value-of select="$espacioSeparador" />
							<xsl:value-of select="$ProxCobroMensaj"/>
							<xsl:value-of select="$espacioSeparador" />
							<xsl:value-of select="$nextChargeDate" />
						</xsl:if>-->
		
				</xsl:if>

		<xsl:if test="$FacCall = 998">
			
		<!-- <xsl:value-of select="$textSaldo" />
		     			<xsl:value-of select="$espacioSeparador" />
			<xsl:value-of
				select="format-number($BS,'########0,00','espaniol')" /> -->
			<xsl:value-of select="$espacioSeparador" />
			<xsl:value-of select="$mensajePlanAnulacion" />
			
			
		</xsl:if>

		<xsl:if test="$FacCall = 999">
			
			<xsl:value-of select="$textSaldo" />
			<xsl:value-of select="$espacioSeparador" />
			<xsl:value-of
				select="format-number($BS,'########0,00','espaniol')" />
			<xsl:value-of select="$espacioSeparador" />
			<xsl:value-of select="$mensajePreactiva" />
			
			
		</xsl:if>

								
								
								

			<xsl:choose>
				<xsl:when test="contains(rtbs:COSName,' ZF')">
					<xsl:variable name="NewCosName">
						<xsl:call-template name="replaceCharsInString">
							<xsl:with-param name="stringIn" select="string(substring-before(rtbs:COSName,' ZF'))"/>
							<xsl:with-param name="charsIn" select="' '"/>
							<xsl:with-param name="charsOut" select="''"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$NewCosName" />
				</xsl:when>
				<xsl:when test="contains(rtbs:COSName,'ZF')">
					<xsl:variable name="NewCosName">
						<xsl:call-template name="replaceCharsInString">
							<xsl:with-param name="stringIn" select="string(substring-before(rtbs:COSName,'ZF'))"/>
							<xsl:with-param name="charsIn" select="' '"/>
							<xsl:with-param name="charsOut" select="''"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$NewCosName" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="NewCosName">
						<xsl:call-template name="replaceCharsInString">
							<xsl:with-param name="stringIn" select="string(rtbs:COSName)"/>
							<xsl:with-param name="charsIn" select="' '"/>
							<xsl:with-param name="charsOut" select="''"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$NewCosName" />
				</xsl:otherwise>
			</xsl:choose>
        </xsl:template>


		
<xsl:template name="replaceCharsInString">
  <xsl:param name="stringIn"/>
  <xsl:param name="charsIn"/>
  <xsl:param name="charsOut"/>
  <xsl:choose>
    <xsl:when test="contains($stringIn,$charsIn)">
      <xsl:value-of select="concat(substring-before($stringIn,$charsIn),$charsOut)"/>
      <xsl:call-template name="replaceCharsInString">
        <xsl:with-param name="stringIn" select="substring-after($stringIn,$charsIn)"/>
        <xsl:with-param name="charsIn" select="$charsIn"/>
        <xsl:with-param name="charsOut" select="$charsOut"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$stringIn"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="replaceDecimal">
  <xsl:param name="stringIn"/>
  <xsl:choose>
    <xsl:when test="contains($stringIn,'.')">
      <xsl:value-of select="substring-before($stringIn,'.')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$stringIn"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 18/05/2016 GH: Se agrega plantilla para evaluar si en el balance Main existe valor NaN para cambiarlo por un valor real -->

<xsl:template name="isNaN">
	<xsl:param name="doubleIn"/>
	<xsl:choose>
		<xsl:when test="string(number($doubleIn))='NaN'">0</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$doubleIn"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
						
</xsl:stylesheet>

