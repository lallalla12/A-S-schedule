package com.management.as.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.management.as.domain.CustomerVO;
import com.management.as.mapper.CustomerMapper;

@Service
public class YahooServiceImpl implements YahooService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<CustomerVO> list(String type, String keyword, String status_keyword, int offset, int pageSize) {
        return customerMapper.alllist(type, keyword, status_keyword, offset, pageSize);
    }

    @Override
    public int totalCount(String type, String keyword, String status_keyword) {
        return customerMapper.alltotalCount(type, keyword, status_keyword);
    }
}