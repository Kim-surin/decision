package com.kpmg.kdb.util;


import java.util.Iterator;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONObject;

/**
 * Restful api 호출 관련 Class
 * 
 * @author D.Cat
 * @since 2024.04
 * 
 */
public class RestfulClientUtil {

    public static Map<String, Object> requestToFlask(String callUrl, Map<String, Object> bodyParam  ) throws Exception {
        RestTemplate restTemplate = new RestTemplate();

        // Header set	
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        // Message
        HttpEntity<?> requestMessage = new HttpEntity<>(bodyParam, httpHeaders);

        // Request
        HttpEntity<String> response = restTemplate.postForEntity(callUrl, requestMessage, String.class);
        // Response 파싱
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
        Map<String, Object> responseMap = objectMapper.readValue(response.getBody(), Map.class);
        return responseMap;
    }

}
