1. 喜马拉雅听不了了----原因是公司的网络,手机连接wifi也播放不了
2. habit不能用了
3. 不想一手的sr就是没时间玩游戏了
4. 想换个不吃内存cpu占用低一点的火狐
5.想整理下那么多chrome,gae和书签,扩展程序,vimium
6.爱奇艺播放不了
7.全都和服务优化有关
8.想看派派网诗歌朗诵自动下一曲呢结果找不到人家播放的地址和代码
9. dos到目录貌似使用cmder然后就无法cmd启动bwengine!
-------------------------------------------------------------------------------------

百度盘前缀都知道吧/s/1jIzy86q 密码：ertn	
-------------------------------------------------------------------------------------

candy 怎么直接用写好的Label或者函数? 那就更厉害了.
或者允许执行多行命令
-------------------------------------------------------------------------------------
https://tibcomc.webex.com/join/yawu

应该是While ClassID <> ""  为空时循环
-------------------------------------------------------------------------------------

..\Collect\_FirstCollect.ahk
-------------------------------------------------------------------------------------
 public static void createKeyPairs() throws Exception {  
        //Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());  
        // create the keys  
//        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA", "BC");  
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");  
        generator.initialize(512, new SecureRandom());  
        KeyPair pair = generator.generateKeyPair();  
        PublicKey pubKey = pair.getPublic();  
        PrivateKey privKey = pair.getPrivate();  
        byte[] pk = pubKey.getEncoded();  
        byte[] privk = privKey.getEncoded();  
        String strpk = new String(Base64.encode(pk));  
        String strprivk = new String(Base64.encode(privk));  
      
        System.out.println("公钥:" + Arrays.toString(pk));  
        System.out.println("私钥:" + Arrays.toString(privk));  
        System.out.println("公钥Base64编码:" + strpk);  
        System.out.println("私钥Base64编码:" + strprivk);  
      
        X509EncodedKeySpec pubX509 = new X509EncodedKeySpec(Base64.decode(strpk));  
        PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decode(strprivk));  
      
        KeyFactory keyf = KeyFactory.getInstance("RSA");  
//        KeyFactory keyf = KeyFactory.getInstance("RSA", "BC");  
        PublicKey pubkey2 = keyf.generatePublic(pubX509);  
        PrivateKey privkey2 = keyf.generatePrivate(priPKCS8);  
      
        System.out.println(pubKey.equals(pubkey2));  
        System.out.println(privKey.equals(privkey2));  
      }  
    
-------------------------------------------------------------------------------------
    static KeyPairGenerator keyPairGen;
 
    static KeyPair keyPair;
 
    static RSAPrivateKey privateKey;
 
    static RSAPublicKey publicKey;
	
	 public static final String usage =
	"Usage: java RSAEncrypt <file1> <file2>...\n" +
	"   or: java RSAEncrypt <file1> ...";
 
    static {
        try {
            // 实例类型
            keyPairGen = KeyPairGenerator.getInstance("RSA");
            // 初始化长度
            keyPairGen.initialize(512);
            // 声场KeyPair
            keyPair = keyPairGen.generateKeyPair();
            // Generate keys
            privateKey = (RSAPrivateKey) keyPair.getPrivate();
            publicKey = (RSAPublicKey) keyPair.getPublic();
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
-------------------------------------------------------------------------------------
<url>file://G:/SRAll/ToAttach/SSL/GenerateCert/server.p12</url>
        <fileType>PKCS12</fileType>
        <passPhrase>#!a27aJvHrskFFbadbrc2dzVPB7bg0ioCSmq91Etnk2/Q=</passPhrase>
-------------------------------------------------------------------------------------

E:\tibco513\bw\5.13\examples\activities\soap\soap_over_http_X509_using_p12_expose_security_context\soap_over_http_X509_using_p12_expose_security_context_FromRobert\Shared_Resources\Identity_p12.id
-------------------------------------------------------------------------------------

<!-- <xs:attribute ref="xml:lang" use="required"/>  -->   


src-resolve.4.2: Error resolving component 'xs:lang'. It was detected that 'xs:lang' is in namespace 'http://www.w3.org/2001/XMLSchema', but components from this namespace are not referenceable from schema document 'file:///C:/Users/Administrator/workspace/SOAP1.2ValidationError1.module/Schemas/SOAP1.2.xsd'. If this is the incorrect namespace, perhaps the prefix of 'xs:lang' needs to be changed. If this is the correct namespace, then an appropriate 'import' tag should be added to 'file:///C:/Users/Administrator/workspace/SOAP1.2ValidationError1.module/Schemas/SOAP1.2.xsd'.
-------------------------------------------------------------------------------------

#server_heartbeat_client = 3
#client_timeout_server_connection = 10

client_heartbeat_server=3 
server_timeout_client_connection=10
-------------------------------------------------------------------------------------

!+c::
send ^c
GoSub,ActivateRunZ
DisplayResult(RunAndGetOutput(clipboard))
return
-------------------------------------------------------------------------------------

^!+r::
send ^c
gosub AhkTest
return
-------------------------------------------------------------------------------------

!+z::ClickNoParmsA("TUiButton.UnicodeClass1")
-------------------------------------------------------------------------------------

!+h::
SearchHHBetter()
return
-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------

账号skc2015
-------------------------------------------------------------------------------------

密码：mima2015
-------------------------------------------------------------------------------------

这个是ftp
-------------------------------------------------------------------------------------

sql：118.123.16.37  账号密码和ftp一样
-------------------------------------------------------------------------------------

skc2015.gotoftp4.com  21
-------------------------------------------------------------------------------------

<?php
    mysql_connect('127.0.0.1','root','123456');
    $sql='select id,num from db.table';
    $res=mysql_query($sql);
    $num2='';
    echo 'id num 大小';  
    while($row=mysql_fetch_array($res)){
        echo $row['id'];
        echo ' '; 
        echo $row['num'];
        echo ' ';
        if ($row['num']>$num2) echo '大';   
        elseif ($row['num']<$num2) echo '小'; 
        else echo '同'; 
        echo '';
        $num2=$row['num'];  
    }
    mysql_free_result($res);
    mysql_close();       
?>
-------------------------------------------------------------------------------------

http://zozhu.com/index.php?str=habit
-------------------------------------------------------------------------------------

<?xml version = "1.0" encoding = "UTF-8"?>
<ns0:WriteActivityInputBinaryClass xmlns:ns0 = "http://www.tibco.com/namespaces/tnt/plugins/file">
	<fileName>F:\GeekWorkLearn\Cmder\LogbackEclipse\SSLCollect\src\HelloEnc2.class</fileName>
	<binaryContent>﻿yv66vgADAC0AwQEAHmNvbS9jcHcvdGliY28vc2VjdXJpdHkvQ3J5cHRlcgcAAQEAEGphdmEvbGFuZy9PYmplY3QHAAMBAA1yc2FLZXlGYWN0b3J5AQAaTGphdmEvc2VjdXJpdHkvS2V5RmFjdG9yeTsBAAlyc2FDaXBoZXIBABVMamF2YXgvY3J5cHRvL0NpcGhlcjsBAAdlbmNvZGVyAQAYTHN1bi9taXNjL0JBU0U2NEVuY29kZXI7AQAHZGVjb2RlcgEAGExzdW4vbWlzYy9CQVNFNjREZWNvZGVyOwEADEhFTFBfU1RSSU5HUwEAFFtbTGphdmEvbGFuZy9TdHJpbmc7AQAIPGNsaW5pdD4BAAMoKVYBAARDb2RlDAAFAAYJAAIAEgwABwAICQACABQBABZzdW4vbWlzYy9CQVNFNjRFbmNvZGVyBwAWAQAGPGluaXQ+DAAYABAKABcAGQwACQAKCQACABsBABZzdW4vbWlzYy9CQVNFNjREZWNvZGVyBwAdCgAeABkMAAsADAkAAgAgAQADUlNBCAAiAQAYamF2YS9zZWN1cml0eS9LZXlGYWN0b3J5BwAkAQALZ2V0SW5zdGFuY2UBAC4oTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZhL3NlY3VyaXR5L0tleUZhY3Rvcnk7DAAmACcKACUAKAEAE2phdmF4L2NyeXB0by9DaXBoZXIHACoBACkoTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZheC9jcnlwdG8vQ2lwaGVyOwwAJgAsCgArAC0BABNqYXZhL2xhbmcvVGhyb3dhYmxlBwAvAQAPcHJpbnRTdGFja1RyYWNlDAAxABAKADAAMgEAE1tMamF2YS9sYW5nL1N0cmluZzsHADQBABBqYXZhL2xhbmcvU3RyaW5nBwA2AQALcmVhZEtleURhdGEIADgBADRSZWFkcyB0aGUgc3BlY2lmaWVkIEZpbGUgYW5kIGdpdmVzIGJhY2sgYSBieXRlIGFycmF5CAA6AQAccmVhZEtleURhdGEoU3RyaW5nIGZpbGVOYW1lKQgAPAEAUVJlYWRzIHRoZSBjb250ZW50cyBvZiB0aGUgZmlsZSBzcGVjaWZpZWQgaW4gdGhlIGFyZ3VtZW50IGFuZCByZXR1cm5zIGEgYnl0ZSBhcnJheQgAPgEADWVuY3J5cHRTdHJpbmcIAEABAGJFbmNyeXB0cyB0aGUgc3RyaW5nIHBhc3NlZCBpbiB0aGUgYXJndW1lbnQgdXNpbmcgdGhlIHB1YmxpYyBrZXkgZmlsZSBwYXNzZWQgYXMgdGhlIHNlY29uZCBhcmd1bWVudAgAQgEALmVuY3J5cHRTdHJpbmcoJGlucHV0U3RyaW5nLCRwdWJsaWNLZXlGaWxlUGF0aCkIAEQBADhSZWFkcyB0aGUgcHVibGljIGtleSBhbmQgZW5jcnlwdHMgdGhlIGdpdmVuIGlucHV0U3RyaW5nIAgARgEADWRlY3J5cHRTdHJpbmcIAEgBAGNEZWNyeXB0cyB0aGUgc3RyaW5nIHBhc3NlZCBpbiB0aGUgYXJndW1lbnQgdXNpbmcgdGhlIHByaXZhdGUga2V5IGZpbGUgcGFzc2VkIGFzIHRoZSBzZWNvbmQgYXJndW1lbnQIAEoBADNkZWNyeXB0U3RyaW5nKCRlbmNyeXB0ZWRTdHJpbmcsJHByaXZhdGVLZXlGaWxlUGF0aCkIAEwBAD1SZWFkcyB0aGUgcHJpdmF0ZSBrZXkgYW5kIGRlY3J5cHRzIHRoZSBnaXZlbiBlbmNyeXB0ZWRTdHJpbmcgCABODAANAA4JAAIAUAEAJmphdmEvc2VjdXJpdHkvTm9TdWNoQWxnb3JpdGhtRXhjZXB0aW9uBwBSAQAjamF2YXgvY3J5cHRvL05vU3VjaFBhZGRpbmdFeGNlcHRpb24HAFQBAA9MaW5lTnVtYmVyVGFibGUBABJMb2NhbFZhcmlhYmxlVGFibGUBAAFlAQAoTGphdmEvc2VjdXJpdHkvTm9TdWNoQWxnb3JpdGhtRXhjZXB0aW9uOwEAJUxqYXZheC9jcnlwdG8vTm9TdWNoUGFkZGluZ0V4Y2VwdGlvbjsKAAQAGQEABHRoaXMBACBMY29tL2Nwdy90aWJjby9zZWN1cml0eS9DcnlwdGVyOwEAFihMamF2YS9sYW5nL1N0cmluZzspW0IBAApFeGNlcHRpb25zAQATamF2YS9pby9JT0V4Y2VwdGlvbgcAYAEAF2phdmEvaW8vRmlsZUlucHV0U3RyZWFtBwBiAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWDAAYAGQKAGMAZQEAHWphdmEvaW8vQnl0ZUFycmF5T3V0cHV0U3RyZWFtBwBnCgBoABkBAARyZWFkAQADKClJDABqAGsKAGMAbAEABXdyaXRlAQAEKEkpVgwAbgBvCgBoAHABAAlhdmFpbGFibGUMAHIAawoAYwBzAQALdG9CeXRlQXJyYXkBAAQoKVtCDAB1AHYKAGgAdwEABWNsb3NlDAB5ABAKAGMAegEAFGphdmEvaW8vT3V0cHV0U3RyZWFtBwB8AQAFZmx1c2gMAH4AEAoAfQB/CgBoAHoBAAhmaWxlTmFtZQEAEkxqYXZhL2xhbmcvU3RyaW5nOwEAA2ZpcwEAGUxqYXZhL2lvL0ZpbGVJbnB1dFN0cmVhbTsBAARiYW9zAQAfTGphdmEvaW8vQnl0ZUFycmF5T3V0cHV0U3RyZWFtOwEAB2tleURhdGEBAAJbQgEAOChMamF2YS9sYW5nL1N0cmluZztMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbGFuZy9TdHJpbmc7BwCJDAA4AF4KAAIAjAEAJWphdmEvc2VjdXJpdHkvc3BlYy9YNTA5RW5jb2RlZEtleVNwZWMHAI4BAAUoW0IpVgwAGACQCgCPAJEBAA5nZW5lcmF0ZVB1YmxpYwEANyhMamF2YS9zZWN1cml0eS9zcGVjL0tleVNwZWM7KUxqYXZhL3NlY3VyaXR5L1B1YmxpY0tleTsMAJMAlAoAJQCVAQAEaW5pdAEAFyhJTGphdmEvc2VjdXJpdHkvS2V5OylWDACXAJgKACsAmQEACGdldEJ5dGVzDACbAHYKADcAnAEAB2RvRmluYWwBAAYoW0IpW0IMAJ4AnwoAKwCgAQAZc3VuL21pc2MvQ2hhcmFjdGVyRW5jb2RlcgcAogEABmVuY29kZQEAFihbQilMamF2YS9sYW5nL1N0cmluZzsMAKQApQoAowCmAQATamF2YS9sYW5nL0V4Y2VwdGlvbgcAqAEAA3BhbgEAC2tleUZpbGVQYXRoAQAJZW5jcnlwdGVkAQAKZW5jb2RlZEtleQEAJ0xqYXZhL3NlY3VyaXR5L3NwZWMvWDUwOUVuY29kZWRLZXlTcGVjOwEAFUxqYXZhL2xhbmcvRXhjZXB0aW9uOwEAJmphdmEvc2VjdXJpdHkvc3BlYy9QS0NTOEVuY29kZWRLZXlTcGVjBwCwCgCxAJEBAA9nZW5lcmF0ZVByaXZhdGUBADgoTGphdmEvc2VjdXJpdHkvc3BlYy9LZXlTcGVjOylMamF2YS9zZWN1cml0eS9Qcml2YXRlS2V5OwwAswC0CgAlALUBABlzdW4vbWlzYy9DaGFyYWN0ZXJEZWNvZGVyBwC3AQAMZGVjb2RlQnVmZmVyDAC5AF4KALgAugoANwCRAQAMZW5jcnlwdGVkUGFuAQAoTGphdmEvc2VjdXJpdHkvc3BlYy9QS0NTOEVuY29kZWRLZXlTcGVjOwEAClNvdXJjZUZpbGUBAAxDcnlwdGVyLmphdmEAIQACAAQAAAAFAAoABQAGAAAACgAHAAgAAAAKAAkACgAAAAoACwAMAAAAGQANAA4AAAAFAAgADwAQAAEAEQAAATkABwABAAAAlQGzABMBswAVuwAXWbcAGrMAHLsAHlm3AB+zACESI7gAKbMAExIjuAAuswAVpwAQSyq2ADOnAAhLKrYAMwa9ADVZAwe9ADdZAxI5U1kEEjtTWQUSPVNZBhI/U1NZBAe9ADdZAxJBU1kEEkNTWQUSRVNZBhJHU1NZBQe9ADdZAxJJU1kEEktTWQUSTVNZBhJPU1OzAFGxAAIAHAAvAC8AUwAcAC8ANwBVAAIAVgAAAGYAGQAAACAABAAhAAgAIgASACMAHAApACQAKgAvACwAMAAuADcAMAA4ADIAPAA7AEIAPABIADwAUgA9AFkAPABdAD4AYwA+AG0APwB0AD4AeABAAH4AQACIAEEAjwBAAJAAOwCUAB4AVwAAABYAAgAwAAQAWABZAAAAOAAEAFgAWgAAAAEAGAAQAAEAEQAAAC8AAQABAAAABSq3AFuxAAAAAgBWAAAABgABAAAAHgBXAAAADAABAAAABQBcAF0AAAAJADgAXgACAF8AAAAEAAEAYQARAAAAogADAAQAAAA2uwBjWSq3AGZMuwBoWbcAaU2nAAssK7YAbbYAcSu2AHSd//QstgB4Tiu2AHsstgCALLYAgS2wAAAAAgBWAAAAKgAKAAAARgAJAEcAEQBIABQASgAcAEgAIwBMACgATQAsAE4AMABPADQAUABXAAAAKgAEAAAANgCCAIMAAAAJAC0AhACFAAEAEQAlAIYAhwACACgADgCIAIkAAwAJAEAAigABABEAAAC+AAQABQAAAD4BwACLTSu4AI1OuwCPWS23AJI6BLIAFQSyABMZBLYAlrYAmrIAFSq2AJ22AKFNpwAITi22ADOyABwstgCnsAABAAUAMQAxAKkAAgBWAAAAIgAIAAAAVAAFAFcACgBYABQAWQAjAFoAMQBcADIAXwA2AGEAVwAAAD4ABgAAAD4AqgCDAAAAAAA+AKsAgwABAAUAOQCsAIkAAgAKACcAiACJAAMAFAAdAK0ArgAEADIABABYAK8AAwAJAEgAigABABEAAACqAAUABAAAADgruACNTbsAsVkstwCyTrIAFQWyABMttgC2tgCauwA3WbIAFbIAISq2ALu2AKG3ALywTSy2ADMBsAABAAAAMQAxAKkAAgBWAAAAHgAHAAAAaAAFAGkADgBqABwAawAxAG0AMgBwADYAcgBXAAAANAAFAAAAOAC9AIMAAAAAADgAqwCDAAEABQAsAIgAiQACAA4AIwCtAL4AAwAyAAQAWACvAAIAAQC/AAAAAgDA</binaryContent>
</ns0:WriteActivityInputBinaryClass>
-------------------------------------------------------------------------------------

<?xml version = "1.0" encoding = "UTF-8"?>
<ns0:WriteActivityInputBinaryClass xmlns:ns0 = "http://www.tibco.com/namespaces/tnt/plugins/file">
	<fileName>F:\GeekWorkLearn\Cmder\LogbackEclipse\SSLCollect\src\HelloEnc2.class</fileName>
	<binaryContent>yv66vgADAC0AwQEAHmNvbS9jcHcvdGliY28vc2VjdXJpdHkvQ3J5cHRlcgcAAQEAEGphdmEvbGFuZy9PYmplY3QHAAMBAA1yc2FLZXlGYWN0b3J5AQAaTGphdmEvc2VjdXJpdHkvS2V5RmFjdG9yeTsBAAlyc2FDaXBoZXIBABVMamF2YXgvY3J5cHRvL0NpcGhlcjsBAAdlbmNvZGVyAQAYTHN1bi9taXNjL0JBU0U2NEVuY29kZXI7AQAHZGVjb2RlcgEAGExzdW4vbWlzYy9CQVNFNjREZWNvZGVyOwEADEhFTFBfU1RSSU5HUwEAFFtbTGphdmEvbGFuZy9TdHJpbmc7AQAIPGNsaW5pdD4BAAMoKVYBAARDb2RlDAAFAAYJAAIAEgwABwAICQACABQBABZzdW4vbWlzYy9CQVNFNjRFbmNvZGVyBwAWAQAGPGluaXQ+DAAYABAKABcAGQwACQAKCQACABsBABZzdW4vbWlzYy9CQVNFNjREZWNvZGVyBwAdCgAeABkMAAsADAkAAgAgAQADUlNBCAAiAQAYamF2YS9zZWN1cml0eS9LZXlGYWN0b3J5BwAkAQALZ2V0SW5zdGFuY2UBAC4oTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZhL3NlY3VyaXR5L0tleUZhY3Rvcnk7DAAmACcKACUAKAEAE2phdmF4L2NyeXB0by9DaXBoZXIHACoBACkoTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZheC9jcnlwdG8vQ2lwaGVyOwwAJgAsCgArAC0BABNqYXZhL2xhbmcvVGhyb3dhYmxlBwAvAQAPcHJpbnRTdGFja1RyYWNlDAAxABAKADAAMgEAE1tMamF2YS9sYW5nL1N0cmluZzsHADQBABBqYXZhL2xhbmcvU3RyaW5nBwA2AQALcmVhZEtleURhdGEIADgBADRSZWFkcyB0aGUgc3BlY2lmaWVkIEZpbGUgYW5kIGdpdmVzIGJhY2sgYSBieXRlIGFycmF5CAA6AQAccmVhZEtleURhdGEoU3RyaW5nIGZpbGVOYW1lKQgAPAEAUVJlYWRzIHRoZSBjb250ZW50cyBvZiB0aGUgZmlsZSBzcGVjaWZpZWQgaW4gdGhlIGFyZ3VtZW50IGFuZCByZXR1cm5zIGEgYnl0ZSBhcnJheQgAPgEADWVuY3J5cHRTdHJpbmcIAEABAGJFbmNyeXB0cyB0aGUgc3RyaW5nIHBhc3NlZCBpbiB0aGUgYXJndW1lbnQgdXNpbmcgdGhlIHB1YmxpYyBrZXkgZmlsZSBwYXNzZWQgYXMgdGhlIHNlY29uZCBhcmd1bWVudAgAQgEALmVuY3J5cHRTdHJpbmcoJGlucHV0U3RyaW5nLCRwdWJsaWNLZXlGaWxlUGF0aCkIAEQBADhSZWFkcyB0aGUgcHVibGljIGtleSBhbmQgZW5jcnlwdHMgdGhlIGdpdmVuIGlucHV0U3RyaW5nIAgARgEADWRlY3J5cHRTdHJpbmcIAEgBAGNEZWNyeXB0cyB0aGUgc3RyaW5nIHBhc3NlZCBpbiB0aGUgYXJndW1lbnQgdXNpbmcgdGhlIHByaXZhdGUga2V5IGZpbGUgcGFzc2VkIGFzIHRoZSBzZWNvbmQgYXJndW1lbnQIAEoBADNkZWNyeXB0U3RyaW5nKCRlbmNyeXB0ZWRTdHJpbmcsJHByaXZhdGVLZXlGaWxlUGF0aCkIAEwBAD1SZWFkcyB0aGUgcHJpdmF0ZSBrZXkgYW5kIGRlY3J5cHRzIHRoZSBnaXZlbiBlbmNyeXB0ZWRTdHJpbmcgCABODAANAA4JAAIAUAEAJmphdmEvc2VjdXJpdHkvTm9TdWNoQWxnb3JpdGhtRXhjZXB0aW9uBwBSAQAjamF2YXgvY3J5cHRvL05vU3VjaFBhZGRpbmdFeGNlcHRpb24HAFQBAA9MaW5lTnVtYmVyVGFibGUBABJMb2NhbFZhcmlhYmxlVGFibGUBAAFlAQAoTGphdmEvc2VjdXJpdHkvTm9TdWNoQWxnb3JpdGhtRXhjZXB0aW9uOwEAJUxqYXZheC9jcnlwdG8vTm9TdWNoUGFkZGluZ0V4Y2VwdGlvbjsKAAQAGQEABHRoaXMBACBMY29tL2Nwdy90aWJjby9zZWN1cml0eS9DcnlwdGVyOwEAFihMamF2YS9sYW5nL1N0cmluZzspW0IBAApFeGNlcHRpb25zAQATamF2YS9pby9JT0V4Y2VwdGlvbgcAYAEAF2phdmEvaW8vRmlsZUlucHV0U3RyZWFtBwBiAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWDAAYAGQKAGMAZQEAHWphdmEvaW8vQnl0ZUFycmF5T3V0cHV0U3RyZWFtBwBnCgBoABkBAARyZWFkAQADKClJDABqAGsKAGMAbAEABXdyaXRlAQAEKEkpVgwAbgBvCgBoAHABAAlhdmFpbGFibGUMAHIAawoAYwBzAQALdG9CeXRlQXJyYXkBAAQoKVtCDAB1AHYKAGgAdwEABWNsb3NlDAB5ABAKAGMAegEAFGphdmEvaW8vT3V0cHV0U3RyZWFtBwB8AQAFZmx1c2gMAH4AEAoAfQB/CgBoAHoBAAhmaWxlTmFtZQEAEkxqYXZhL2xhbmcvU3RyaW5nOwEAA2ZpcwEAGUxqYXZhL2lvL0ZpbGVJbnB1dFN0cmVhbTsBAARiYW9zAQAfTGphdmEvaW8vQnl0ZUFycmF5T3V0cHV0U3RyZWFtOwEAB2tleURhdGEBAAJbQgEAOChMamF2YS9sYW5nL1N0cmluZztMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbGFuZy9TdHJpbmc7BwCJDAA4AF4KAAIAjAEAJWphdmEvc2VjdXJpdHkvc3BlYy9YNTA5RW5jb2RlZEtleVNwZWMHAI4BAAUoW0IpVgwAGACQCgCPAJEBAA5nZW5lcmF0ZVB1YmxpYwEANyhMamF2YS9zZWN1cml0eS9zcGVjL0tleVNwZWM7KUxqYXZhL3NlY3VyaXR5L1B1YmxpY0tleTsMAJMAlAoAJQCVAQAEaW5pdAEAFyhJTGphdmEvc2VjdXJpdHkvS2V5OylWDACXAJgKACsAmQEACGdldEJ5dGVzDACbAHYKADcAnAEAB2RvRmluYWwBAAYoW0IpW0IMAJ4AnwoAKwCgAQAZc3VuL21pc2MvQ2hhcmFjdGVyRW5jb2RlcgcAogEABmVuY29kZQEAFihbQilMamF2YS9sYW5nL1N0cmluZzsMAKQApQoAowCmAQATamF2YS9sYW5nL0V4Y2VwdGlvbgcAqAEAA3BhbgEAC2tleUZpbGVQYXRoAQAJZW5jcnlwdGVkAQAKZW5jb2RlZEtleQEAJ0xqYXZhL3NlY3VyaXR5L3NwZWMvWDUwOUVuY29kZWRLZXlTcGVjOwEAFUxqYXZhL2xhbmcvRXhjZXB0aW9uOwEAJmphdmEvc2VjdXJpdHkvc3BlYy9QS0NTOEVuY29kZWRLZXlTcGVjBwCwCgCxAJEBAA9nZW5lcmF0ZVByaXZhdGUBADgoTGphdmEvc2VjdXJpdHkvc3BlYy9LZXlTcGVjOylMamF2YS9zZWN1cml0eS9Qcml2YXRlS2V5OwwAswC0CgAlALUBABlzdW4vbWlzYy9DaGFyYWN0ZXJEZWNvZGVyBwC3AQAMZGVjb2RlQnVmZmVyDAC5AF4KALgAugoANwCRAQAMZW5jcnlwdGVkUGFuAQAoTGphdmEvc2VjdXJpdHkvc3BlYy9QS0NTOEVuY29kZWRLZXlTcGVjOwEAClNvdXJjZUZpbGUBAAxDcnlwdGVyLmphdmEAIQACAAQAAAAFAAoABQAGAAAACgAHAAgAAAAKAAkACgAAAAoACwAMAAAAGQANAA4AAAAFAAgADwAQAAEAEQAAATkABwABAAAAlQGzABMBswAVuwAXWbcAGrMAHLsAHlm3AB+zACESI7gAKbMAExIjuAAuswAVpwAQSyq2ADOnAAhLKrYAMwa9ADVZAwe9ADdZAxI5U1kEEjtTWQUSPVNZBhI/U1NZBAe9ADdZAxJBU1kEEkNTWQUSRVNZBhJHU1NZBQe9ADdZAxJJU1kEEktTWQUSTVNZBhJPU1OzAFGxAAIAHAAvAC8AUwAcAC8ANwBVAAIAVgAAAGYAGQAAACAABAAhAAgAIgASACMAHAApACQAKgAvACwAMAAuADcAMAA4ADIAPAA7AEIAPABIADwAUgA9AFkAPABdAD4AYwA+AG0APwB0AD4AeABAAH4AQACIAEEAjwBAAJAAOwCUAB4AVwAAABYAAgAwAAQAWABZAAAAOAAEAFgAWgAAAAEAGAAQAAEAEQAAAC8AAQABAAAABSq3AFuxAAAAAgBWAAAABgABAAAAHgBXAAAADAABAAAABQBcAF0AAAAJADgAXgACAF8AAAAEAAEAYQARAAAAogADAAQAAAA2uwBjWSq3AGZMuwBoWbcAaU2nAAssK7YAbbYAcSu2AHSd//QstgB4Tiu2AHsstgCALLYAgS2wAAAAAgBWAAAAKgAKAAAARgAJAEcAEQBIABQASgAcAEgAIwBMACgATQAsAE4AMABPADQAUABXAAAAKgAEAAAANgCCAIMAAAAJAC0AhACFAAEAEQAlAIYAhwACACgADgCIAIkAAwAJAEAAigABABEAAAC+AAQABQAAAD4BwACLTSu4AI1OuwCPWS23AJI6BLIAFQSyABMZBLYAlrYAmrIAFSq2AJ22AKFNpwAITi22ADOyABwstgCnsAABAAUAMQAxAKkAAgBWAAAAIgAIAAAAVAAFAFcACgBYABQAWQAjAFoAMQBcADIAXwA2AGEAVwAAAD4ABgAAAD4AqgCDAAAAAAA+AKsAgwABAAUAOQCsAIkAAgAKACcAiACJAAMAFAAdAK0ArgAEADIABABYAK8AAwAJAEgAigABABEAAACqAAUABAAAADgruACNTbsAsVkstwCyTrIAFQWyABMttgC2tgCauwA3WbIAFbIAISq2ALu2AKG3ALywTSy2ADMBsAABAAAAMQAxAKkAAgBWAAAAHgAHAAAAaAAFAGkADgBqABwAawAxAG0AMgBwADYAcgBXAAAANAAFAAAAOAC9AIMAAAAAADgAqwCDAAEABQAsAIgAiQACAA4AIwCtAL4AAwAyAAQAWACvAAIAAQC/AAAAAgDA</binaryContent>
</ns0:WriteActivityInputBinaryClass>
-------------------------------------------------------------------------------------

version:=1.0.0.0707.bat	;预设版本信息
name:="habit"
Update(version,name,endlist)	;更新函数
return
Update(version,name,endlist){
	req := ComObjCreate("Msxml2.XMLHTTP")
	req.open("GET","http://zozhu.com/index.php?str="name,false)
	req.Send()
	Gui,Add,Text,,最新版本：1.2.17.0810.bat
	Gui,Add,Edit,w300 r20 ReadOnly -Tabstop,% req.responseText
	Gui,Add,Button,xm Section,取消更新
	Gui,Add,Button,ys Default,立即更新
	;Gui,Add,Progress,ys hp+ vguipor,
	;GuiControl,,guipor,100
	Gui,Show
}

-------------------------------------------------------------------------------------
version:=1.0.0.0707.bat	;预设版本信息
name:="habit"
Update(version,name,endlist)	;更新函数
return
Update(version,name,endlist){
	req := ComObjCreate("Msxml2.XMLHTTP")
	req.open("GET","http://zozhu.com/index.php?name=" name "&&ver=" version,false)
	req.Send()
	Gui,Add,Text,,最新版本：1.2.17.0810.bat
	Gui,Add,Edit,w300 r20 ReadOnly -Tabstop,% req.responseText
	Gui,Add,Button,xm Section,取消更新
	Gui,Add,Button,ys Default,立即更新
	;Gui,Add,Progress,ys hp+ vguipor,
	;GuiControl,,guipor,100
	Gui,Show
}

-------------------------------------------------------------------------------------

<?php
$con = mysql_connect("localhost:3306","skc2015","mima2015");
mysql_select_db("skc2015", $con);
$result = mysql_query("SELECT * FROM " . $_GET['str'] . " WHERE version >'1.0.0.0707.bat' ORDER BY version DESC");
while($row = mysql_fetch_array($result))
	{
		echo $row['version'];
		echo "\r\n";
		echo $row['news'];
		echo "\r\n";
	}
mysql_close($con);
?>
-------------------------------------------------------------------------------------


[texttype]
txtxmletc         = run|%npp% "{text}"
srnum             = web|http://10.106.148.71/sr/{text}
kbnum             = web|http://10.106.148.71/ka/000/{text}.htm
Email             = run|mailto:{text}
;email            = {Setclipboard:pure}
weburl            = run|%qqbrowner% {text}
shorttext         = menu|短文本
longtext          = menu|长文本
MagnetLink        = run|%Thunder% magnet:?xt=urn:btih:{text}
;MagnetLink       = run|%Thunder% {text}
ThunderLink       = run|%Thunder% {text}
FtpLink           = run|%Thunder% {text}
;ed2kLink          = run|%Thunder% {text}

[filetype]
;----特别的文件后缀-------------------------------------------------------
folder            = menu|文件夹
anyfile           = menu|通用菜单
multifiles        = menu|多文件
RightMenu	  = menu|右键菜单
-------------------------------------------------------------------------------------

openfile.*(?=ahk)
-------------------------------------------------------------------------------------

openfile.*(?=ahk)
-------------------------------------------------------------------------------------

openfile("F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\FuckAHK.xml")
openfile("F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\folderLink.xml")
openfile("F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\folderLinkFiles.xml")
openfile("F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\RecentLink.xml")
openfile("F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\AllAhkLearn.xml")
-------------------------------------------------------------------------------------

"F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\FuckAHK.xml"
"F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\folderLink.xml"
"F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\folderLinkFiles.xml"
"F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\RecentLink.xml"
"F:\Program Files\AutoHotkey\Scripts\Good\ListViewFolder\AllAhkLearn.xml"
-------------------------------------------------------------------------------------

"F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\FuckAHK.xml"
F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\folderLink.xml
"F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\folderLinkFiles.xml"
"F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\RecentLink.xml"
"F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\FromAutoHotkeyScriptFolder\Good\ListViewFolder\AllAhkLearn.xml"
-------------------------------------------------------------------------------------

<?php
$con = mysql_connect("localhost:3306","skc2015","mima2015");
mysql_select_db("skc2015",$con);
$result = mysql_query("SELECT * FROM habit",$con);
$rsArray=array();
while($row=mysql_fetch_array($result,MYSQL_ASSOC)){
    $rsArray[]=$row;
}
print_r($rsArray);
mysql_close($con);
?>
-------------------------------------------------------------------------------------

<?php
$con = mysql_connect("localhost:3306","skc2015","mima2015");
mysql_select_db("skc2015", $con);
$result = mysql_query("SELECT * FROM " . $_GET['name'] . " WHERE version >'" . $_GET['ver'] . "' ORDER BY version DESC");
while($row = mysql_fetch_array($result))
	{
		echo $row['version'];
		echo "\r\n";
		echo $row['news'];
		echo "\r\n----------------------------------------------\r\n";
	}
mysql_close($con);
?>
-------------------------------------------------------------------------------------

<?php
header("content-type:text/html; charset=GBK");
$con = mysql_connect("localhost:3306","skc2015","mima2015");
mysql_select_db("skc2015",$con);
$result = mysql_query("SELECT * FROM habit",$con);
$arr = array ('a'=>1,'b'=>2,'c'=>3,'d'=>4,'e'=>5);
echo json_encode($arr);
print_r($result);
//echo json_encode($result);
$rsArray=array();
while($row=mysql_fetch_array($result,MYSQL_ASSOC)){
    $rsArray[]=$row;
	echo json_encode($row);
}
//print_r($rsArray);
mysql_close($con);
?>
-------------------------------------------------------------------------------------

<?php
header("content-type:text/html; charset=GBK");
$con = mysql_connect("localhost:3306","skc2015","mima2015");
mysql_select_db("skc2015",$con);
$result = mysql_query("SELECT * FROM habit",$con);

//$arr = array ('a'=>1,'b'=>2,'c'=>3,'d'=>4,'e'=>5);
//echo json_encode($arr);
//print_r($result);
//echo json_encode($result);

$rsArray=array();
while($row=mysql_fetch_array($result,MYSQL_ASSOC)){
    //$rsArray[]=$row;
    $rsArray[]=json_encode($row);
	//echo json_encode($row);
}
print_r($rsArray);
mysql_close($con);
?>
-------------------------------------------------------------------------------------


// print_r(mysql_fetch_array($result,MYSQL_ASSOC));

/**
$foodsPic = mysql_fetch_array($result,MYSQL_ASSOC);
print_r($foodsPic);break;
return $foodsPic;
 改成：
$foodsPic=array();
while($row=mysql_fetch_array($result)){
    $foodsPic[]=$row;
}
print_r($foodsPic);
*/
-------------------------------------------------------------------------------------

while($row = $mysql_fetch_array($result)){
$data[]=$row;
}
-------------------------------------------------------------------------------------

os程序中不识别读取到的JSON数据中 \u开头的数据。

PHP 生成JSON的时候，必须将汉字不转义为 \u开头的UNICODE数据。

网上很多，但是其实都是错误的，正确的方法是在json_encode 中加入一个参数 JSON_UNESCAPED_UNICODE 
-------------------------------------------------------------------------------------

    json_encode($data, JSON_UNESCAPED_UNICODE); //必须PHP5.4+  
-------------------------------------------------------------------------------------

http://zozhu.com/BakUp_Work_Final/get.php

http://zozhu.com/getJson.php
-------------------------------------------------------------------------------------

{{"version":"1.0.0.0707.bat","news":"文本中使用中文","download":"http:\/\/www.baidu.com","compatible":null,"downloads":"0"},{"version":"1.0.0.0709.bat","news":"提供更新功能","download":"http:","compatible":null,"downloads":"0"}}
-------------------------------------------------------------------------------------

php将数据集合返回为json
-------------------------------------------------------------------------------------

其实很简单，只要在php文件头部加入以下代码:
-------------------------------------------------------------------------------------

header('Content-type: text/json');
-------------------------------------------------------------------------------------

< ?php
header('Content-type: text/json');

$fruits = array (
    "fruits"  => array("a" => "orange", "b" => "banana", "c" => "apple"),
    "numbers" => array(1, 2, 3, 4, 5, 6),
    "holes"   => array("first", 5 => "second", "third")
);
echo json_encode($fruits);
?>
-------------------------------------------------------------------------------------

[{"name":"LiuSha","author":"2","describe":"聚散流沙","icon":null,"label":"gui","heat":"200","dowurl":"http:\/\/yun.rrsyycm.com","compatible":"8-10"}]

-------------------------------------------------------------------------------------

[{"name":"LiuSha","author":"2","describe":"聚散流沙","icon":null,"label":"gui","heat":"200","dowurl":"http:\/\/yun.rrsyycm.com","compatible":"8-10"},{"name":"LiuShaVimd","author":"2","describe":"聚散流沙 vimd","icon":"","label":"gui","heat":"200","dowurl":"http:\/\/yun.rrsyycm.com","compatible":"8-10"}]
-------------------------------------------------------------------------------------

1.对json数据格式的转码和解码是通过：json_encode和json_decode进行的，具体的过程可以参考php文档。

2.mysql_fetch_array() 中可选的第二个参数 result_type 是一个常量，可以接受以下值：MYSQL_ASSOC，MYSQL_NUM 和 MYSQL_BOTH。本特性是 PHP 3.0.7 起新加的。本参数的默认值是 MYSQL_BOTH。如果用了 MYSQL_BOTH，将得到一个同时包含关联和数字索引的数组。用 MYSQL_ASSOC 只得到关联索引（如同 mysql_fetch_assoc() 那样），用 MYSQL_NUM 只得到数字索引（如同 mysql_fetch_row() 那样）。
-------------------------------------------------------------------------------------

start /b G:\SysManage\SoftFolders\winscp556\WinSCP.exe root:tibco123@192.168.68.145:%1/share/
-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------

2：手机彻底关机之后，然后手机要进入recovery模式，进入该模式有两种方法：

第一种方法：手机在关机的状态下，同时按住电源键和音量上键，等待屏幕亮起后会进入Recovery模式，再次点击电源键会出现相应的操作菜单。

第二种方法：手机在正常的待机界面找到  版本升级 -点击菜单键-重启到刷机模式，等待重启就会进入到Recovery模式（需要在30%以上的电量进行）。

3：进入recovery模式之后，选择【wipe data/factory reset】，然后按音量上键或电源键确认，再选择【yes - delete all data】即可
-------------------------------------------------------------------------------------

Rashr_v2.2.8.apk
-------------------------------------------------------------------------------------

TCL M2M么么哒3N刷recovery教程_TCL 么么哒3N中文recovery
-------------------------------------------------------------------------------------


Rashr_v2.2.8.apk
-------------------------------------------------------------------------------------

mon 7 18 20:48 CDT
-------------------------------------------------------------------------------------

TRA 5.9.0 Hotfix-07 (LBN 45251) / TRA 5.9.1 Hotfix-02  or latest available hotfix (LBN 45612) must be installed before installing BW 5.12 Hotfix-11.
-------------------------------------------------------------------------------------

E:\EasyOSLink\PCMasterMove\Downloads\Compressed\20160627\RTCIS_LIVE3-NA-IDOC-PE_root
-------------------------------------------------------------------------------------

JavaCustomFunction_ConvertProcess
-------------------------------------------------------------------------------------

# An alternate java.security properties file may be specified
# from the command line via the system property
#
#    -Djava.security.properties=<URL>
#
# This properties file appends to the master security properties file.
# If both properties files specify values for the same key, the value
# from the command-line properties file is selected, as it is the last
# one loaded.
#
# Also, if you specify
#
#    -Djava.security.properties==<URL> (2 equals),
#
# then that properties file completely overrides the master security
# properties file.
#
# To disable the ability to specify an additional properties file from
# the command line, set the key security.overridePropertiesFile
# to false in the master security properties file. It is set to true
# by default.
-------------------------------------------------------------------------------------

add below property in application tra / bwengine.tra file.

java.property.log4j.configuration=<path to log4j.xml>
-------------------------------------------------------------------------------------

PartnerMessage:getPartnerErrorCode($_globalVariables/pfx14:GlobalVariables/ErrorCodes/parser_error, $_globalVariables/pfx14:GlobalVariables/ErrorCodes/context_search)
-------------------------------------------------------------------------------------

<!--
	<xsd:attribute name="version" type="xsd:string"/>
	--></xsd:attribute>
-------------------------------------------------------------------------------------

Q.OLTP.ACTIMIZEPROXY.SEARCHWLF.SYNC.REQUEST.XML.1603 
Q.OLTP.ACTIMIZEPROXY.PERFORMWLF.SYNC.REQUEST.XML.1603

-------------------------------------------------------------------------------------

   As you see, I am just replacing the old "noNamespaceSchemaLocation" string to "xsi:noNamespaceSchemaLocation".

   Finally, I found another way to achieve the goal : editing the element in the "OriginalContent_Correct" activity.

   Please check attached two process and a picture .

   RetrieveFlightAvail_ForCustomer_ReplaceString.process :  shows that either a mapper or a java code activity could be used to replace the string.

   RetrieveFlightAvail_ForCustomer_EditElement.process :  has edited the element to make the attribute having the namespace prefix as seen in attached picture.

  
-------------------------------------------------------------------------------------

zjkypjy4086487

18231358112

E:\EasyOSLink\PCMasterMove\Downloads\Compressed\20160627\2016-07-15\ear\Shared Archive\B2Bi\Util\ConfigCache.javaxpath.class
-------------------------------------------------------------------------------------

concat(substring-before($Render-XML/xmlString,'noNamespaceSchemaLocation' ),'xsi:noNamespaceSchemaLocation',substring-after($Render-XML/xmlString,'noNamespaceSchemaLocation'))

<OverrideInput xsi:noNamespaceSchemaLocation="http://uat2.aereww.amadeus.com/XMLschemas/V17.0/common/OverrideInput.xsd" version="V17.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  
-------------------------------------------------------------------------------------

<Directory />
Options FollowSymLinks

AllowOverride None

Order deny,allow

Allow from all

Satisfy all

#   AllowOverride none
#   Require all denied
</Directory>

E:/htdocs/frame_export/
-------------------------------------------------------------------------------------


#<VirtualHost *:80>
#    #管理员邮箱
#    ServerAdmin jiangfeng3@staff.sina.com.cn 
#    #项目根目录   
#    DocumentRoot "D:/htdocs/frame_export" 
#	<Directory "D:/htdocs/frame_export">
#    #Options FollowSymLinks
#    Options Indexes FollowSymLinks Includes ExecCGI
#    AllowOverride All
#    Order deny,allow
#    Allow from all
#	</Directory>
#    #域名  
#    ServerName localhost
#    #别名                      
#    ServerAlias test.t.sina.com.cn
#    #错误日志路径
#    ErrorLog "logs/test.t.sins.com.cn-error.log"
#    CustomLog "logs/test.t.sins.com.cn-access.log" common
#    RewriteEngine on
#    #重写规则，可根据实际需要添加
#    RewriteRule  ^/(.*)$       /index.html [L]
#</VirtualHost>
-------------------------------------------------------------------------------------

http://jingyan.baidu.com/article/e9fb46e17e36707520f76646.html按这个方法创建了一个快捷方式，然后随便放到一个文件夹，run命令，搞定
-------------------------------------------------------------------------------------

ahk怎么给edge浏览器设置快捷键，就是怎么给win10应用设置快捷键？
-------------------------------------------------------------------------------------

ahk怎么给edge浏览器设置快捷键，就是怎么给win10应用设置快捷键？
-------------------------------------------------------------------------------------

人找车,下午5点以后从张家口桥东区马路东街道 张家口职业技术学院(张家口桥东燕兴机械厂南边)走,回北京回龙观新村西二旗附近.一人 18519103730
-------------------------------------------------------------------------------------

FileLocator Pro - 搜索: wintab 在 F:\Program Files\AutoHotkey\Scripts\AHK Script Manager\scripts\
ahk_class Afx:00007FF69EE30000:8:0000000000010003:0000000000000000:00000000000206F7
ahk_exe FileLocatorPro.exe

2 个文件被找到 - 搜索: wintab 在 F:\Program Files\AutoHotkey\Scripts\AHK Script Manager\scripts\
ahk_class Afx:00007FF69EE30000:8:0000000000010003:0000000000000000:00000000000206FD
ahk_exe FileLocatorPro.exe
-------------------------------------------------------------------------------------

menuentry '系统救援(WinPE)' --users=root {
    if search --file --set --no-floppy /SysManage/BootOSPE/iso/Ghost_Win10_X64_Pro_1511_PE.iso; then
        linux16  /grub2/i386-pc/memdisk iso raw
        initrd16 /SysManage/BootOSPE/iso/Ghost_Win10_X64_Pro_1511_PE.iso
    fi
}
-------------------------------------------------------------------------------------

Dear customer,

   1. Since you are using BW 5.9.3, please consider upgrade your JRE to JRE 1.6.0_105 which has fixed the issue as confirmed by our other customers.

   2. Another way to work around in application level, is to use a separate java.security file for your application by adding below line in application.tra :
	#java.extended.properties=-Djava.security.properties==file:///E:\tibco513\tibcojre64\1.8.0\lib\security\java_tls1.security
	#java.extended.properties=-Djava.security.properties==file:///E:/tibco513/tibcojre64/1.8.0/lib/security/java_tls1.security
	#java.extended.properties=-Djava.security.properties==E:/tibco513/tibcojre64/1.8.0/lib/security/java_tls1.security
   
    Please note , line like "java.extended.properties=-Djava.security.properties==E:\tibco513\tibcojre64\1.8.0\lib\security\java_tls1.security" would always fail and causes designer unable to start since it may not be recognized by designer !
	
    Kindly let me know if above suggestions would help you .

$formula($global.my_email_signature)

-------------------------------------------------------------------------------------

ahk自动生成所有快捷键的列表 cheetsheet
-------------------------------------------------------------------------------------

(A_Cursor="Unknown")?0:1
-------------------------------------------------------------------------------------

++\
-------------------------------------------------------------------------------------

;在某些程序中自动切换中文，某些英文
Gui +LastFound +hwndhwndshellwindow
DllCall( "RegisterShellHookWindow", "UInt",hwndshellwindow )
OnMessage( DllCall( "RegisterWindowMessage", "Str", "SHELLHOOK" ), "ShellMessage" )
Return
ShellMessage( wParam,lParam ) 
{
	If ( wParam = 1 )
	{
	WinGetclass, WinClass, ahk_id %lParam%
	Sleep 1000
    If Winclass in TXGuiFoundation,Notepad2U,OpusApp,XLMAIN,Chrome_WidgetWin_1,EVERYTHING,SDL_app,StandardFrame,WeChatMainWndForPC,TFoxComposeForm.UnicodeClass	;开启中文输入法状态的窗口class 
		{
		winget,WinID,id,ahk_class %WinClass%
		SetLayout("E0220804",WinID)         ;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts
		;TrayTip,AHK, 自动切换到搜狗五笔输入法
		;SoundBeep, 1000, 100
		;gosub cursors
		return
		}
	If Winclass in Photoshop
		{
		winget,WinID,id,ahk_class %WinClass%
		SetLayout("4090409",WinID)         ;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts
		;TrayTip,AHK, 自动切换到拼音输入法
		;gosub cursors
		return
		}
	
	}
}
这个你值得拥有

-------------------------------------------------------------------------------------

Dear customer,

   Sorry for the delay to update.

  

   The error is resulted by BW 5.13 HF 05 you have applied.

 

   I have reproduced the error once I use BW 5.13 HF 05.

 

   You could see it works if you do not use BW 5.13 HF 05.

 

   I am checking further to see if there are any documents or information about this before we esvalate this to engineers.


$formula($global.my_email_signature)


PS: Please click here to login to TSC and update the SR. 
-------------------------------------------------------------------------------------

java.property.com.tibco.security.wss4j.NO_UT_NONCE_ENCODING=true
-------------------------------------------------------------------------------------



关于软件
名字：澄海3C改键工具
版本：V1.0
时间：2016.08.01

关于功能
1、一键回城
2、快速换传
3、内置改建（非作者不可修改）
*/

SetWorkingDir %A_ScriptDir% 
CoordMode,Mouse,window
SetMouseDelay, -1
SetFormat,Float,1
#InstallKeybdHook
#InstallMouseHook
SetControlDelay, 0

;默认为黑暗
;血泉位置
X1 :=A_ScreenWidth*171/1600			;默认坐标x1
Y1 :=A_ScreenHeight*684/900			;默认坐标y1
;传送位置
X2 :=A_ScreenWidth*683/1600			;默认坐标x2
Y2 :=A_ScreenHeight*641/900			;默认坐标y2

;Gui
Menu,Tray,NoStandard
Menu,Tray,add,显示
Menu,Tray,add,关于
Menu,Tray,add,退出
Menu,Tray,Default,显示

Gui,Add,GroupBox,x10 y10 w120 h140 cred, ☆回城☆
Gui, Add, Text, x20 y30 w30 h20,热键:
Gui, Add, Edit, x60 y28 w55 h20 v热键 -Multi,*$wheelup
Gui, Add, Text, x20 y60 w30 h20,时间:
Gui, Add, Edit, x60 y58 w55 h20 v时间 -Multi,50
Gui, Add, Text, x20 y90 w30 h20,  X :
Gui, Add, Edit, x60 y88 w55 h20  v坐标1 -Multi,%x1%
Gui, Add, Text, x20 y120 w30 h20,  Y :
Gui, Add, Edit, x60 y118 w55 h20  v坐标2 -Multi,%y1%

Gui,Add,GroupBox,x145 y10 w120 h140 cred, ☆换传☆
Gui, Add, Text, x155 y30 h20,热键:  WheelDown
Gui, Add, Text, x155 y60 h20,时间:    50
Gui, Add, Text, x155 y90 w30 h20,  X :
Gui, Add, Edit, x195 y88 w55 h20  v坐标3 -Multi,%x2%
Gui, Add, Text, x155 y120 w30 h20,  Y :
Gui, Add, Edit, x195 y118 w55 h20  v坐标4 -Multi,%y2%

gui,add,Text,x9 y155 cgreen, 1、【回城】先用Alt + d 获取生命源泉处的坐标
gui,add,Text,x9 y175 cgreen, 2、【换传】先用Alt + c 获取背包里传送的坐标  

;Gui, Add, Button, x215 y190 w50 h25, 确定    ;若不自己输入坐标，此行可以不需要。
goSub,Button确定							  ;若上行需要，则此行删除

Gui, Show, Center  , 澄海3C改键工具
Return

;命令
GuiClose:
goSub,Button确定	
gui,Hide
return

显示:
gui,Show
return

关于:
tray关于=
(
关于作者
QQ名:Sone
QQ号:3300372390

关于软件
名字：澄海3C改键工具
版本：V1.0
时间：2016.08.01

关于功能
1、一键回城
2、快速换传
3、内置改键（非作者不可修改）
)
msgbox,%tray关于%
return

退出:
ExitApp
return

Button确定:
if  热键2
Hotkey,%热键2%,off
gui,Submit
Hotkey, IfWinActive,Warcraft III
Hotkey,%热键%,主体,on
Hotkey,*$WheelDown,换传,on
热键2 :=热键
return

主体:
send,{Numpad7}
BlockInput,on
Click %坐标1%,%坐标2%
sleep,%时间%
Click
BlockInput,off
return

换传:
if A_Priorkey = WheelDown
	return
MouseGetPos,ox,oy
BlockInput,on
MouseClick ,Right,%坐标3%, %坐标4%,,0
Sleep,50
MouseMove,%ox%,%oy%,0
BlockInput,off
return

;获取坐标
!d::							
MouseGetPos,_xx,_yy
GuiControl,Text,Edit3,%_xx%
GuiControl,Text,Edit4,%_yy%
goto,Button确定
return

!c::
MouseGetPos,_xx1,_yy1
GuiControl,Text,Edit5,%_xx1%
GuiControl,Text,Edit6,%_yy1%
goto,Button确定
return

;改键块
#Ifwinactive,Warcraft III
F9::suspend,on
F10::suspend,off
F1::6
6::F1
F2::7
F3::8
F4::9
`::Numpad7
Space::Numpad4
Capslock::Numpad5
v::Numpad2
q::v
mbutton::h
Lwin::return
~RButton & LCtrl::
^RButton::
send,{RButton}
send,+h
return

-------------------------------------------------------------------------------------

I created a temporary fix of capturing the exception caused by system variable not having a valid reference after which basic authentication works.

Engineering needs to evaluate what code changes need to be made to BW5.11 to use a valid classloader so that ojdbc6 can be initialized without issues.

The issue likely exists in TRA5.8 HF6 onwards and TRA5.9 and BW5.12 combination, will test and update shortly.
-------------------------------------------------------------------------------------

The root cause of the issue is that TRA 5.9 is packaged with Tomcat 7.0.52 and BW 5.11 tries to use a classloader that was available in Tomcat 7.0.30 but is not available in 7.0.52. The class loader is in the 'system' variable in BWWebAppClassLoader.

In 7.0.30 the system variable is initialized with a valid classloader, in 7.0.52 the system variable is left as null and this causes a exception which causes the ojdbc6 driver not to be initialized and causes Basic authentication to fail.
-------------------------------------------------------------------------------------

2.  make sure you append below lines at the end of designer.tra :


  java.property.TIBCO_SECURITY_VENDOR=j2se

  java.property.javax.net.debug=ssl,plaintext,record,handshake

  java.property.java.security.egd=file:/dev/./urandom
-------------------------------------------------------------------------------------

1. do not start at one time
2. reprodued after seveal minutes 

3. note customer HF 19 change psp to PSP
-------------------------------------------------------------------------------------

RobertWork短文本=F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\Scripts\Candy_Kawvin改版(2016.04.27)\ini\Candy_RobertWork\短文本.ini
菜单式短文本=F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\Scripts\Candy_Kawvin改版(2016.04.27)\ini\Candy_菜单式\短文本.ini
次常用短文本=F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\Scripts\Candy_Kawvin改版(2016.04.27)\ini\Candy_次常用\短文本.ini
-                                  = 
-------------------------------------------------------------------------------------

Dear customer,

    Thanks for contacting TIBCO Support.

    1. Windows-MY is a type of keystore on Windows which is managed by the Windows operating system.

   Since it's a kind of native keystore, Java doesn't have a general API to access it.

   To help Java applications access the keys and certificates stored in Windows-MY keystore, Java provides a separate API -- SunMSCAPI.

    Below link shows extra provier should be installed to use Windows Keystores :

http://www.pixelstech.net/article/1452337547-Different-types-of-keystore-in-Java----Windows-MY

    2. Still, we didn't see customers use Windows Keystore to set up a web service via SOAP SSL.


    It appears to me impossible to specify the identity to use Windows Keystore since we see the "identity" activity uses file url to load identity but you are unable to instruct the application on where the key(inside Windows Keystore) is stored.

 

    It seems only possible in pure java code to access a key in Windows-MY keystore .

 

   3. To use a PKCS12 (*.p12, or *.pfx) file or JKS(.jks) files is absolutely the easy way to set up an identity for a ssl server.

   I am attaching a sample project I built up before and the identity file for you.

   Kindly check if you could set up your project base on it.


$formula($global.my_email_signature)


PS: Please click here to login to TSC and update the SR. 
-------------------------------------------------------------------------------------

bw.plugin.service.jms.confirmOnError=false
-------------------------------------------------------------------------------------

Trace.Task.*=true
bw.engine.showInput=true
bw.engine.showOutput=true
bw.plugin.http.server.debug=true
java.property.com.tibco.plugin.soap.trace.filename=soap0809.txt
java.property.com.tibco.plugin.soap.trace.inbound=true
java.property.com.tibco.plugin.soap.trace.outbound=true
java.property.com.tibco.plugin.soap.trace.pretty=true
java.property.com.tibco.plugin.soap.trace.stderr=true
java.property.com.tibco.plugin.soap.trace.stdin=true
java.property.com.tibco.plugin.soap.trace.stdout=true
-------------------------------------------------------------------------------------

现象：打开word文件时，会弹出3个警告框“Word 无法创建工作文件，请检查临时环境变量”

原因：使用了内存盘Primo Ramdisk Ultimate Edition软件，修改过IE的缓存目录位置，内存盘崩溃后，这个目录不存在了。由于word要使用IE的缓存路径创建临时文件，所以会弹出上述的警告框。

解决方法：开始>运行>regedit，然后定位到HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\Cache，把Cache的值改为默认值%USERPROFILE%\Local Settings\Temporary Internet Files，关闭注册表，重启机子再打开word文档，正常了
-------------------------------------------------------------------------------------

HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Extensions
-------------------------------------------------------------------------------------

%A_ScriptDir%\Scripts\AHKInfo\
%A_ScriptDir%\Scripts\AHKManager\
%A_ScriptDir%\Scripts\AHK帮助\
%A_ScriptDir%\Scripts\AutoSpellCorrect\
%A_ScriptDir%\Scripts\Candy_Kawvin改版(2016.04.27)\
%A_ScriptDir%\Scripts\ClipboardHistory\
%A_ScriptDir%\Scripts\Collect\
%A_ScriptDir%\Scripts\DragKing\
%A_ScriptDir%\Scripts\FavoriteItem\
%A_ScriptDir%\Scripts\gmailSimple\
%A_ScriptDir%\Scripts\GoodClock\
%A_ScriptDir%\Scripts\GoodLockGood\
%A_ScriptDir%\Scripts\HotKeyManagerV1\
%A_ScriptDir%\Scripts\Libs\
%A_ScriptDir%\Scripts\MoreFunctions\
%A_ScriptDir%\Scripts\QQActive\
%A_ScriptDir%\Scripts\QuickZ_LL定制_20151206\
%A_ScriptDir%\Scripts\Scriptlet Library\
%A_ScriptDir%\Scripts\Shortcuts\
%A_ScriptDir%\Scripts\stepbystep_根据不同的进程名出不同的菜单\
%A_ScriptDir%\Scripts\VimDesktop\
%A_ScriptDir%\Scripts\VimEdit\
%A_ScriptDir%\Scripts\WinTabSwitchApp\
%A_ScriptDir%\Scripts\屏幕变暗\
%A_ScriptDir%\Scripts\正则测试\
%A_ScriptDir%\Scripts\获取签名\
-------------------------------------------------------------------------------------

HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Extensions

HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit
-------------------------------------------------------------------------------------

      0 [main] cntlm 6164 find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer.  Please report this problem to
the public mailing list cygwin@cygwin.com
cygwin warning:
  MS-DOS style path detected: C:\Program Files (x86)\Cntlm\cntlm.ini
  Preferred POSIX equivalent is: /cygdrive/c/Program Files (x86)/Cntlm/cntlm.ini
  CYGWIN environment variable option "nodosfilewarning" turns off this warning.
  Consult the user's guide for more details about POSIX paths:
    http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
Exitting with error. Check daemon logs or run with -v.

-------------------------------------------------------------------------------------

2016 Aug 12 06:10:05:028 GMT +0800 BW.TestCase Debug [org.apache.commons.httpclient.HttpMethodDirector] BW-EXT-LOG-300002 Preemptively sending default basic credentials 
2016 八月 12 06:10:05:028 CST   Authenticating with BASIC <any realm>@localhost:8888 
2016 Aug 12 06:10:05:029 GMT +0800 BW.TestCase Debug [org.apache.commons.httpclient.HttpMethodDirector] BW-EXT-LOG-300002 Authenticating with BASIC <any realm>@localhost:8888 
2016 Aug 12 06:10:05:030 GMT +0800 BW.TestCase Debug [org.apache.commons.httpclient.params.HttpMethodParams] BW-EXT-LOG-300002 Credential charset not configured, using HTTP element charset 
2016 Aug 12 06:10:05:030 GMT +0800 BW.TestCase Debug [org.apache.commons.httpclient.HttpMethodDirector] BW-EXT-LOG-300002 Authenticating with BASIC <any realm>@localhost:8089 

-------------------------------------------------------------------------------------

2016 Aug 12 05:59:52:905 GMT +0800 BW.TestCase Debug [org.apache.commons.httpclient.auth.AuthChallengeProcessor] BW-EXT-LOG-300002 05:59:52  Supported authentication schemes in the order of preference: [ntlm, digest, basic, ntlm, ntlm] 
 
八月 12 05:59:52  Challenge for ntlm authentication scheme not available 
 
八月 12 05:59:52  Challenge for digest authentication scheme not available 
 
八月 12 05:59:52  Challenge for digest authentication scheme not available 
2016 Aug 12 05:59:52:911 GMT +0800 BW.TestCase Info [org.apache.commons.httpclient.auth.AuthChallengeProcessor] BW-EXT-LOG-300000 05:59:52  basic authentication scheme selected 
-------------------------------------------------------------------------------------

jfkwsi63!
-------------------------------------------------------------------------------------

Dear customer,
    Thanks for contacting TIBCO Support. 
	 
	 As you mentioned GC takes a lot of time in the application,it seems more Heap Memory or Perm Memory needed.
	  
	 Before we suggest properties to increase above memory, could you please share your observation data i.e, GC log ?
	 
	 If you do not have a clear data, please use below tip to generate GC log so we could decide the suggestions better.

    Please 	append below lines to application.tra and restart the application by "nohup ./app.sh &":
	
	java.extended.properties=-Xincgc -verbose\:gc -XX\:PrintGCTimeStamps -XX\:PrintGCDateStamps -XX\:UseGCLogFileRotation -Xloggc\:/tmp/supportGC0812.log -XX\:PrintGCDetails
	
	Change above "/tmp/supportGC0812.log" to a place which is valid in your OS.
	
	When you see the issue reproduced , please share the nohup.out file and above GC log file and tell the timestamps we should check for the performance.
	
-------------------------------------------------------------------------------------

1). The "filename" value must use an existing folder where the user has privileges. In other words, the property would report "file/directory not found" if there is no such folder. The property has only the privilege to create the file but not the folder.

2). The file path pattern must resemble "c:/temp/soaptest.xml", if you use "c:\temp\soaptest.xml". The application will report "illegal file/directory" in Windows.

3). Check the BW log, TSM log or nohup.out if the SOAP log is not created. You will find error messages in those log files warning that you are using a non-existing folder or wrong pattern.


----------------------------------------------------------------------------------------------
java.property.com.tibco.plugin.soap.trace.inbound=true
java.property.com.tibco.plugin.soap.trace.outbound=true
java.property.com.tibco.plugin.soap.trace.filename=c:/temp/soapNM20160126test.xml
java.property.com.tibco.plugin.soap.trace.pretty=true
java.property.com.tibco.plugin.soap.trace.stdout=true

-------------------------------------------------------------------------------------

BW uses the Apache HTTPClient 3.x library for HTTP which only support NTLMv1. BW HTTP activities and SOAP activities will not work with NTMLv2. Apache HTTPCLient 4.x does support NTLMv2. One of the options would be to use the Apache HTTPCLient 4.x for a proxy implementation. Another option would be to use custom Java code for the authentication.

There is an existing enhancement for supporting NTLM V2(BW-15571) which is not implemented as of BW 5.13. You could use tools like Fiddler (http://www.telerik.com/fiddler) to confirm if a server is using NTLM v1 or v2. Fiddler is a free web debugging proxy which logs all HTTP traffic between your computer and the Internet. Attached is a screenshot (Filename: fiddler.png) that shows an example for NTLM v2. Also attached is a sample BW project (Filename: BW_ntlmv2.zip) that uses a Java URLConnection to authenticate with NTLM v2
-------------------------------------------------------------------------------------


E:\tibco513\tra\domain\513Admin59\application\JaraB2B-2_2_0>JaraB2B-2_2_0-Process_Archive.cmd > debug.txt 2>&1
-------------------------------------------------------------------------------------

E:\tibco513\tra\domain\513Admin59\application\JaraB2B-2_root>JaraB2B-2_root-Process_Archive.cmd > debug.xml 2>&1

-------------------------------------------------------------------------------------

java.property.bw.plugin.mail.enableStartTLS=true


Use attached certificates(NewCerts.zip) and let us know the result.
-------------------------------------------------------------------------------------

G:\SRAll\ToAttach\morePorject\TestGVApplicationLevelAndServiceLevel
-------------------------------------------------------------------------------------
