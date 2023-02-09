import React, { useState, useEffect, useRef } from "react";
import { renderToString } from "react-dom/server";
import { useSelector, useDispatch } from 'react-redux'
import { useNavigate, Link } from 'react-router-dom'

import { Table } from 'smart-webcomponents-react/table';
import { Smart, Form, FormGroup, FormControl } from 'smart-webcomponents-react/form';

import './Article.scss';

import {
  startAction,
  endAction,
  showToast
} from '../../actions/common'
import { logout } from "../../actions/auth";
import agent from '../../api/'

import { useLaravelReactI18n } from 'laravel-react-i18n'

const Article = () => {
  const { t, tChoice } = useLaravelReactI18n();

  const navigate = useNavigate()
  const dispatch = useDispatch()

  const [articles, setArticles] = useState([])

  const articleColumns = [
    {
      label: 'ID',
      dataField: 'id',
      dataType: 'number',
      width: 100
    }, {
      label: t('Object Name'),
      dataField: 'name',
      dataType: 'string'
    }, {
      label: t('Object Type'),
      dataField: 'is_house',
      dataType: 'number',
      formatFunction(settings) {
        settings.template = settings.data.is_house == 0 ? 'Building' : 'House'
      }
    }, {
      label: t('Detail'),
      dataField: '',
      width: 100,
      allowSort: false,
      allowMenu: false,
      formatFunction(settings) {
        settings.template = renderToString(<a className="table_article_edit_btn" data-id={settings.data.id}>{ t('Detail') }</a>);
      }
    }, {
      label: t('Cost'),
      dataField: '',
      width: 100,
      allowSort: false,
      allowMenu: false,
      formatFunction(settings) {
        settings.template = renderToString(<a className="table_article_payment_btn" data-id={settings.data.id}>{ t('Input') }</a>);
      }
    }
  ];
  
  const articleData = new Smart.DataAdapter({
		dataSource: articles,
		dataFields: [
			'id: number',
			'name: string',
			'is_house: number',
      'ended: number',
			'contract_amount: number',
      'budget: array',
      'created_user_id: number',
      'created_user_name: string',
      'created_at: string',
      'updated_user_id: number',
      'updated_user_name: string',
      'updated_at: string',
		]
	});

  useEffect(() => {
    getArticleData()
  }, [])

  const getArticleData = async() => {
    dispatch(startAction())
    try {
      const resArticle = await agent.common.getAllArticle()
      if (resArticle.data.success) {
        setArticles([...resArticle.data.data])
      }
      dispatch(endAction())
    } catch (error) {
      if (error.response.status >= 400 && error.response.status <= 500) {
        dispatch(endAction())
        dispatch(showToast('error', error.response.data.message))
        if (error.response.data.message == 'Unauthorized') {
          localStorage.removeItem('token')
          dispatch(logout())
          navigate('/')
        }
      }
    }
  }

  const clickSearchBtn = () => {
    
  }

  const goArticleEdit = (article_id) => {
    
  }

  const goArticleAdd = () => {
    
  }

  const goArticlePayment = (article_id) => {
    
  }


  return (
    <>
      <div className="page-header">
        <div className="page-block">
          <div className="row align-items-center">
            <div className="col-md-12">
              <div className="page-header-title">
                <h5 className="m-b-10">{ t('Object List') }</h5>
              </div>
              <ul className="breadcrumb">
                <li className="breadcrumb-item">
                  <a href="/"><i className="feather icon-home"></i></a>
                </li>
                <li className="breadcrumb-item">
                  <a href="#!">{ t('Object Management') }</a>
                </li>
                <li className="breadcrumb-item">
                  <a href="/article">{ t('Object List') }</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div className="main-body">
        <div className="page-wrapper">
          <div className="row">
            <div className="col">
              <div className="card">
                <div className="card-header">
                  <h5 className="card-title">{ t('List') }</h5>
                </div>
                <div className="card-body">
                  <div className="row">
                    <div className="col-md-3">
                      <div className="form-group">
                        <label className="form-label">{ t('Object ID') }</label>
                        <input className="form-control" type="text" />
                      </div>
                      <div className="form-group">
                        <label className="form-label">{ t('Object Name') }</label>
                        <input className="form-control" type="text" />
                      </div>
                      <div className="form-group">
                        <label className="form-label">{ t('Object Type') }</label>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input" />
                          <label title="" type="checkbox" className="form-check-label">{ t('Housing') }</label>
                        </div>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input" />
                          <label title="" type="checkbox" className="form-check-label">{ t('Building') }</label>
                        </div>
                      </div>
                      <div className="form-group">
                        <label htmlFor="formBasicEmail" className="form-label">{ t('Display') }</label>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input" />
                          <label title="" type="checkbox" className="form-check-label">{ t('Show hidden properties') }</label>
                        </div>
                      </div>
                      <hr />
                      <button type="button" className="btn btn-primary" onClick={() => clickSearchBtn()}>{ t('Search') }</button>
                    </div>
                    <div className="col-md-9">
                      <div className="table_container">
                        <Table 
                          dataSource={articleData} 
                          // keyboardNavigation
                          paging
                          filtering
                          // tooltip={tooltip}
                          columns={articleColumns} 
                          columnMenu
                          // editing
                          sortMode='many'
                        />
                        <button type="button" className="btn btn-primary table_btn" onClick={() => goArticleAdd()}>{ t('Add') }</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}

export default Article