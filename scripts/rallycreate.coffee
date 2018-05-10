request = require('request')
#fs=require('fs')
#index = require('./index')
#readjson = require './readjson.js'
#finaljson=" ";
#generate_id = require('./mongoConnt')



module.exports = (robot) ->
		robot.respond /create Bug with name (.*) Description (.*) Priority (.*) Severity (.*) State (.*) and  Status(.*)/, (msg) ->
			Name=msg.match[1]
			Description=msg.match[2]
			Priority=msg.match[3]
			Severity=msg.match[4]
			SchState=msg.match[5]
			Status=msg.match[6]
			console.log(typeof(Name)+" "+typeof(Description)+typeof(Priority)+Severity+DefectState)
			
			url=process.env.API+"defect/create";
			options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"POST",body:{Defect:{"Name":Name,"Description":Description,"Priority":Priority,"Severity":Severity,"FlowState._refObjectName":SchState,"State":Status}},json: true};
			request.post options, (error, response, body) ->
				console.log(body)

