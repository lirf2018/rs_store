package com.yufan.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

/**
 * 创建人: lirf
 * 创建时间:  2018/8/22 14:39
 * 功能介绍:  生成取货js地址()
 */
public class GetAddrJs {

    private static volatile GetAddrJs getAddrJs;

    public static GetAddrJs getInstence() {
        if (null == getAddrJs) {
            getAddrJs = new GetAddrJs();
        }
        return getAddrJs;
    }

    /**
     * 调用接口生成地址
     */
    public void methodGetAddr() {
        long st = System.currentTimeMillis();
        //获取省级
        //调用接口
        JSONObject obj1 = new JSONObject();
        obj1.put("parent_id", "000000000000");//
        obj1.put("mark", "1");//
        ResultBean resultBean1 = CommonRequst.executeNew(obj1, "query_global_addr_list");
        JSONArray array1 = resultBean1.getData().getJSONArray("addr_list");
        //1省
        JSONArray arrayOut1 = new JSONArray();//存放省(市-县-镇)
        for (int i1 = 0; i1 < array1.size(); i1++) {
            JSONObject l1 = array1.getJSONObject(i1);
            String l1_code = l1.getString("region_code");
//            if(!"450000000000".equals(l1_code)){
//                continue;
//            }
            //2市==============================================================================
            JSONObject obj2 = new JSONObject();
            obj2.put("parent_id", l1_code);//
            obj2.put("mark", "1");//
            ResultBean resultBean2 = CommonRequst.executeNew(obj2, "query_global_addr_list");
            JSONArray array2 = resultBean2.getData().getJSONArray("addr_list");
            JSONArray arrayOut2 = new JSONArray();//存放市(县-镇)
            for (int i2 = 0; i2 < array2.size(); i2++) {
                JSONObject l2 = array2.getJSONObject(i2);
                String l2_code = l2.getString("region_code");
                //3县==============================================================================
                JSONObject obj3 = new JSONObject();
                obj3.put("parent_id", l2_code);//
                obj3.put("mark", "1");//
                ResultBean resultBean3 = CommonRequst.executeNew(obj3, "query_global_addr_list");
                JSONArray array3 = resultBean3.getData().getJSONArray("addr_list");
                JSONArray arrayOut3 = new JSONArray();//存放县(镇)
                for (int i3 = 0; i3 < array3.size(); i3++) {
                    JSONObject l3 = array3.getJSONObject(i3);
                    String l3_code = l3.getString("region_code");
                    //4镇==============================================================================
                    JSONObject obj4 = new JSONObject();
                    obj4.put("parent_id", l3_code);//
                    obj4.put("mark", "1");//
                    ResultBean resultBean4 = CommonRequst.executeNew(obj4, "query_global_addr_list");
                    JSONArray array4 = resultBean4.getData().getJSONArray("addr_list");

                    l3.put("rsTownList", array4);//镇
                    arrayOut3.add(l3);
//                    for (int i4 = 0; i4 < array4.size(); i4++) {
//                        JSONObject l4 = array4.getJSONObject(i4);
//                        String l4_code = l4.getString("region_code");
//                    }
                }
                l2.put("rsCountyList", arrayOut3);//县
                arrayOut2.add(l2);
            }
            l1.put("rsCityList", arrayOut2);//市
            arrayOut1.add(l1);
        }
        long end = System.currentTimeMillis();
        System.out.println(arrayOut1);
        resultWrite(arrayOut1.toString());
        System.out.println("用时=" + ((end - st) / 1000) + "s");
    }

    public void resultWrite(String str) {
        try {
            BufferedOutputStream buff = null;
            FileOutputStream outFile = new FileOutputStream("C:\\Users\\usersLi\\Desktop\\ydui.citys-my.js");
            buff = new BufferedOutputStream(outFile);
            str = "!function () { \n var citys = " + str + "  if (typeof define === \"function\") {\n" +
                    "        define(citys)\n" +
                    "    } else {\n" +
                    "        window.YDUI_CITYS = citys\n" +
                    "    }\n" +
                    "}();";
            buff.write(str.getBytes());
            buff.flush();
            buff.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        GetAddrJs.getInstence().methodGetAddr();
    }
}
