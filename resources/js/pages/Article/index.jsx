import React, { useState, useEffect, useRef,useCallback  } from "react";
import ReactDOM from 'react-dom'
import { renderToString } from "react-dom/server";
import { useSelector, useDispatch } from 'react-redux'
import { useNavigate, Link } from 'react-router-dom'

import { Table } from 'smart-webcomponents-react/table';
import { CheckBox } from 'smart-webcomponents-react/checkbox';
import { Smart, Form, FormGroup, FormControl } from 'smart-webcomponents-react/form';
import { DropDownList, ListItem } from 'smart-webcomponents-react/dropdownlist';
import { NumberInput } from 'smart-webcomponents-react/numberinput';
import { Input } from 'smart-webcomponents-react/input';
import { RadioButton } from 'smart-webcomponents-react/radiobutton';
import { Button } from  'smart-webcomponents-react/button';
import Select from 'react-select';
import { confirmAlert } from 'react-confirm-alert';

import SimpleReactValidator from 'simple-react-validator';

import { FaYenSign } from "react-icons/fa"
import { IoMdRemoveCircle, IoMdAddCircle } from "react-icons/io"
import {BsExclamationCircle} from "react-icons/bs"

import {useWindowDimensions} from '../../utils/Helper'

import './Article.scss';

import {
  startAction,
  endAction,
  showToast
} from '../../actions/common'
import { logout } from "../../actions/auth";
import agent from '../../api/'

import { useLaravelReactI18n } from 'laravel-react-i18n'

let editable_data = {}

const Article = () => {
  const { t, tChoice } = useLaravelReactI18n();

  const navigate = useNavigate()
  const dispatch = useDispatch()

  const budgetEditTable = useRef()
  const budgetAddTable = useRef()

  const { width } = useWindowDimensions()

  const [page, setPage] = useState('list')
  const [articles, setArticles] = useState([])
  const [articleLog, setArticleLog] = useState([])
  const [articleRecordLog, setArticleRecordLog] = useState([])
  const [budgetLog, setBudgetLog] = useState([])
  const [constructions, setConstructions] = useState([])
  const [editArticle, setEditArticle] = useState({})
  const [addArticle, setAddArticle] = useState({name: '', contract_amount: 0, is_house: 1, ended: 0})
  const [paymentArticle, setPaymentArticle] = useState({})
  const [budgets, setBudgets] = useState([])
  const [addBudget, setAddBudget] = useState({})
  const [budgetRowCount, setBudgetRowCount] = useState(0)

  const [filterArticleData, setFilterArticleData] = useState({
    id: '',
    name: '',
    is_house: -1,
    checkedHouse: false,
    checkedBuilding: false,
    ended: ''
  })

  const [loadBudgetTable, setLoadBudgetTable] = useState(false)

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
    getArticleLog()
    getConstructionOptions()
  }, [])

  const handleArticleTableClick = (event) => {
    const edit_btn = event.target.closest('.table_article_edit_btn')
    const input_btn = event.target.closest('.table_article_payment_btn')

    if(edit_btn) {
      goArticleEdit(edit_btn.getAttribute('data-id'))
    } else if(input_btn) {
      goArticlePayment(input_btn.getAttribute('data-id'))
    }
	}

  const getArticleData = async() => {

    // console.log(filterArticleData)
    
    let r_house
    if(filterArticleData.checkedHouse && !filterArticleData.checkedBuilding) {
      r_house = 1
    } else if(!filterArticleData.checkedHouse && filterArticleData.checkedBuilding) {
      r_house = 0
    } else if((filterArticleData.checkedHouse && filterArticleData.checkedBuilding)||(!filterArticleData.checkedHouse && !filterArticleData.checkedBuilding)) {
      r_house = ''
    }

    dispatch(startAction())
    try {
      console.log('r_house data=', r_house)
      const resArticle = await agent.common.getArticle(filterArticleData.id, filterArticleData.name, r_house, filterArticleData.ended)
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

  const getArticleLog = async() => {
    dispatch(startAction())
    try {
      const resArticleLog = await agent.common.getLogs(1, '')
      if (resArticleLog.data.success) {
        let r_logs = []
        resArticleLog.data.data.map((item) => {
          r_logs.push({...item, type: getTypeText(item.action_type)})
        })
        setArticleLog([...r_logs])
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

  const getConstructionOptions = async(article_id = '') => {
    dispatch(startAction())
    try {
      const resAutoConstruction = await agent.common.getAutoConstruction(article_id)

      if(resAutoConstruction.data.success) {
        let constructionOptions = []
        resAutoConstruction.data.data.map((item) => {
          constructionOptions.push({
            value: item.id,
            label: item.name
          })
        })
        setConstructions([...constructionOptions])
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

  const clickSaveBtn = async() => {
    dispatch(startAction())
		const res = await agent.common.editArticle(editArticle.id, editArticle.name, editArticle.contract_amount, editArticle.is_house, editArticle.ended)
		if (res.data.success) {
      dispatch(showToast('success', res.data.message))
      getArticleData()
      setPage('list')
      setLoadBudgetTable(false)
    }
		else dispatch(showToast('error', res.data.message))
		dispatch(endAction())
  }

  const clickAddArticleBtn = async() => {
    dispatch(startAction())
    let param_budgets = []
    budgets.map((budget) => {
      param_budgets.push({construction_id: budget.construction_id, cost: budget.cost, contract_amount: budget.contract_amount, change_amount: budget.change_amount})
    })
    const res = await agent.common.addArticle(addArticle.name, addArticle.contract_amount, addArticle.is_house, addArticle.ended, param_budgets)
    if (res.data.success) {
      dispatch(showToast('success', res.data.message))
      getArticleData()
      getArticleLog()
      setPage('list')
      setLoadBudgetTable(false)
      setBudgetRowCount(0)
    }
    else dispatch(showToast('error', res.data.message))
    dispatch(endAction())
    console.log('click add submit btn=', addArticle)
    console.log('budgets=', budgets)
  }

  const clickAddBudgetBtn = async() => {
    if(page == 'add') {
      console.log('add budget data=', addBudget)
      setBudgets([...budgets, {id: budgetRowCount, construction_id: addBudget.construction.value, construction_name: addBudget.construction.label, cost: addBudget.cost, contract_amount: addBudget.contract_amount, change_amount: addBudget.change_amount}])
      setAddBudget({construction: {}, cost: 0, contract_amount: 0, change_amount: 0})
      setBudgetRowCount(budgetRowCount + 1)
    } else if(page == 'edit') {
      dispatch(startAction())
      const res = await agent.common.addBudget(Number(addBudget.article_id), Number(addBudget.construction.value), Number(addBudget.cost), Number(addBudget.contract_amount), Number(addBudget.change_amount))
      if (res.data.success) {
        getConstructionOptions(addBudget.article_id)
        setBudgets([...budgets, {id: res.data.data.id, construction_id: res.data.data.construction_id, construction_name: addBudget.construction.label, cost: res.data.data.cost, contract_amount: res.data.data.contract_amount, change_amount: res.data.data.change_amount}])
        setAddBudget({...addBudget, construction: {}, cost: 0, contract_amount: 0, change_amount: 0})
        getArticleData()
        dispatch(showToast('success', res.data.message))
      }
      else dispatch(showToast('error', res.data.message))
      dispatch(endAction())
    }
  }

  const deleteBudget = async(budget_id) => {
    if(page == 'add') {
      const r_budgets = budgets.filter((el) => {
        return el.id != budget_id;
      });
      setBudgets([...r_budgets])

      const r_constructions = constructions.filter((el) => {
        r_budgets.map((item) => {
          return el.value != item.construction_id
        })
      })

      console.log(r_constructions)
      setConstructions([...r_constructions])
    } else if(page == 'edit') {
      dispatch(startAction())
      const res = await agent.common.deleteBudget(budget_id)
      if (res.data.success) {
        const r_budgets = budgets.filter((el) => {
          return el.id != budget_id;
        });
        getConstructionOptions()
        setBudgets([...r_budgets])
        setAddBudget({...addBudget, construction: {...constructions[0]}, cost: 0, contract_amount: 0, change_amount: 0})
        getArticleData()
        dispatch(showToast('success', res.data.message))
      }
      else dispatch(showToast('error', res.data.message))
      dispatch(endAction())
    }
  }

  const clickSearchBtn = () => {
    getArticleData()
  }

  const goArticleEdit = (article_id) => {
    const result = articles.find(article => {
      return article.id == article_id;
    });
    if (result !== undefined) {

      getConstructionOptions(article_id)
      getArticleRecordLogData(article_id)
      getBudgetLogData(article_id)
      setEditArticle({...result})
      setBudgets([...result.budget])
      setAddBudget({...addBudget, article_id: Number(article_id), construction: {}, cost: 0, contract_amount: 0, change_amount: 0})
      setPage('edit')
    }
  }

  const getArticleRecordLogData = async(article_id) => {
    dispatch(startAction())
    try {
      const resArticleRecordLog = await agent.common.getLogs(1, article_id)
      if (resArticleRecordLog.data.success) {
        let r_logs = []
        resArticleRecordLog.data.data.map((item) => {
          r_logs.push({...item, type: getTypeText(item.action_type)})
        })
        setArticleRecordLog([...r_logs])
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

  const getBudgetLogData = async(article_id) => {
    dispatch(startAction())
    try {
      const resBudgetLog = await agent.common.getBudgetLogsByArticleId(article_id)
      if (resBudgetLog.data.success) {
        let r_logs = []
        resBudgetLog.data.data.map((item) => {
          r_logs.push({...item, type: getTypeText(item.action_type)})
        })
        setBudgetLog([...r_logs])
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
                  <a href="/article">{ t('Object Management') }</a>
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
                        <input className="form-control" type="text" value={filterArticleData.id} onChange={(e) => setFilterArticleData({...filterArticleData, id: e.target.value})}/>
                      </div>
                      <div className="form-group">
                        <label className="form-label">{ t('Object Name') }</label>
                        <input className="form-control" type="text" value={filterArticleData.name} onChange={(e) => setFilterArticleData({...filterArticleData, name: e.target.value})}/>
                      </div>
                      <div className="form-group">
                        <label className="form-label">{ t('Object Type') }</label>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input" checked={filterArticleData.checkedHouse} onChange={(e) => setFilterArticleData({...filterArticleData, checkedHouse: e.target.checked})}/>
                          <label title="" type="checkbox" className="form-check-label">{ t('Housing') }</label>
                        </div>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input" checked={filterArticleData.checkedBuilding} onChange={(e) => setFilterArticleData({...filterArticleData, checkedBuilding: e.target.checked})}/>
                          <label title="" type="checkbox" className="form-check-label">{ t('Building') }</label>
                        </div>
                      </div>
                      <div className="form-group">
                        <label htmlFor="formBasicEmail" className="form-label">{ t('Display') }</label>
                        <div className="form-check">
                          <input type="checkbox" className="form-check-input"  checked={filterArticleData.ended == 1} onChange={(e) => setFilterArticleData({...filterArticleData, ended: (e.target.checked ? 1 : 0)})}/>
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
                          paging
                          filtering
                          columns={articleColumns} 
                          columnMenu
                          sortMode='many'
                          onClick={(e) => handleArticleTableClick(e)}
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