request = require('request')
#fs=require('fs')
#index = require('./index')
#readjson = require './readjson.js'
#finaljson=" ";
#generate_id = require('./mongoConnt')



module.exports = (robot) ->

	#help
	robot.respond /help/i, (msg) ->
		dt = "Following are the commands of RALLY :smiley:\n1)list features -->lists the features\n2)list Epics -->lists the Epics\n3)list UserStory -->lists the UserStories\n4)list Bugs -->lists the Bugs\n5)list Tasks -->lists the Tasks\n6)list TestCases -->lists the TestCases\n7)list Releases -->lists the Releases -->lists the Releases\n8)list Iterations -->lists the Iterations\n9)delete feature<objectId> -->Deletes the feature of the objectid\n10)delete Epic<objectId> -->Deletes the Epic of the objectid\n11)delete UserStory<objectId> -->Deletes the Userstory of the objectid\n12)delete Bug<objectId> -->Deletes the Bug of the objectid\n13)delete Task<objectId> -->Deletes the Task of the objectid\n14)delete TestCase<objectId> -->Deletes the TestCase of the objectid\n15)delete Release<objectId> -->Deletes the Release of the objectid\n16)delete Iteration<objectId> -->Deletes the Iteration of the objectid"
		msg.send dt
		
	#list features
	robot.respond /list features/i, (msg) ->
		url=process.env.API+"portfolioitem/feature";
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"}};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			console.log(body);
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name\t\t\t\tType\t\t\tObjectId\n"
			msg.send dt
			console.log(dt);
			for i in [0...feature.length]
				message = feature[i]._refObjectName + '\t\t\t' + feature[i]._type + '\t\t\t' + feature[i]._ref.split('/')[8] + '\n'
				console.log (message)
				msg.send message
	
	#list Epics
	robot.respond /list Epics/i, (msg) ->
		url=process.env.API+"portfolioitem/initiative";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->
			console.log(body);
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			console.log(feature)
			dt="Name\t\t\t\tType\t\t\tObjectId\n"
			msg.send dt
			console.log(dt);
			for i in [0...feature.length]
				message = feature[i]._refObjectName + '\t\t\t' + feature[i]._type + '\t\t\t' + feature[i]._ref.split('/')[8] + '\n'
				console.log (message)
				msg.send message
	
	#list Userstory
	robot.respond /list Userstory/i, (msg) ->
		url=process.env.API+"hierarchicalrequirement";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			message="Name || ObjectId || Status || Project || Iteration\n"
			#console.log(dt);
			msg.send dt
			for i in [0...feature.length]
				url=process.env.API+"hierarchicalrequirement/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body);
					if body.HierarchicalRequirement.Iteration==null
						message=body.HierarchicalRequirement.Name+"||"+body.HierarchicalRequirement.ObjectID+"||"+body.HierarchicalRequirement.FlowState._refObjectName+"||"+body.HierarchicalRequirement.Project._refObjectName+" || "+"not assigned"+"\n"
						console.log(message)
						msg.send message
						
					else
						message=body.HierarchicalRequirement.Name+"||"+body.HierarchicalRequirement.ObjectID+"||"+body.HierarchicalRequirement.FlowState._refObjectName+"||"+body.HierarchicalRequirement.Project._refObjectName+" || "+body.HierarchicalRequirement.Iteration._refObjectName+"\n"						
						console.log(message)
						msg.send message
	
	#list Bugs
	robot.respond /list Bugs/i, (msg) ->
		url=process.env.API+"defect";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name || Description || ObjectId || Status || Priority || Severity || UserStory || Iteration\n"
			console.log(dt)
			msg.send dt
			for i in [0...feature.length]
				url=process.env.API+"defect/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body)
					if body.Defect.Iteration==null
						message=body.Defect.Name+"||"+body.Defect.Description+"||"+body.Defect.ObjectID+"||"+body.Defect.Priority+"||"+body.Defect.Severity+"||"+body.Defect.FlowState._refObjectName+"\n"
						msg.send message
					else
						message=body.Defect.Name+"||"+body.Defect.Description+"||"+body.Defect.ObjectID+"||"+body.Defect.Priority+"||"+body.Defect.Severity+"||"+body.Defect.FlowState._refObjectName+"\n"
						console.log(message)
						msg.send message
	
	#list Tasks
	robot.respond /list Tasks/i, (msg) ->
		url=process.env.API+"task";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->	
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name || Description || ObjectId || Status || Estimate || Userstory || Iteration\n"
			console.log(dt)
			msg.send(dt)
			for i in [0...feature.length]
				url=process.env.API+"task/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body)
					if body.Task.Iteration==null
						message=body.Task.Name+" || "+body.Task.Description+" || "+body.Task.ObjectID+" || "+body.Task.State+" || "+body.Task.Estimate+" || "+body.Task.WorkProduct._refObjectName+" || "+"not assigned"+"\n"
					else
						message=body.Task.Name+" || "+body.Task.Description+" || "+body.Task.ObjectID+" || "+body.Task.State+" || "+body.Task.Estimate+" || "+body.Task.WorkProduct._refObjectName+" || "+body.Task.Iteration._refObjectName+"\n"
					console.log(message)
					msg.send message
					
	#list TestCases
	robot.respond /list TestCases/i, (msg) ->
		url=process.env.API+"testcase";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->	
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name || ObjectID || Userstory || Type || Priority\n"
			console.log(dt)
			msg.send dt
			for i in [0...feature.length]
				url=process.env.API+"testcase/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body)
					message=body.TestCase.Name+" || "+body.TestCase.ObjectID+" || "+body.TestCase.WorkProduct._refObjectName+" || "+body.TestCase.Type+" || "+body.TestCase.Priority+"\n"
					console.log(message)
					msg.send message
	
	#list Releases
	robot.respond /list Releases/i, (msg) ->
		url=process.env.API+"release";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->	
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name || ObjectId || Status\n"
			console.log(dt)
			msg.send dt
			for i in [0...feature.length]
				url=process.env.API+"release/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body)
					message=body.Release.Name+" || "+body.Release.ObjectID+" || "+body.Release.State+"\n"
					console.log(message)
					msg.send message
	
	#list Iterations
	robot.respond /list Iterations/i, (msg) ->
		url=process.env.API+"iteration";
		options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
		request options, (error, response, body) ->	
			body = JSON.parse(body);
			feature=body.QueryResult.Results;
			dt="Name || ObjectID || State"
			console.log(dt)
			msg.send dt
			for i in [0...feature.length]
				url=process.env.API+"iteration/"+feature[i]._ref.split('/')[7];
				options = {url: url,auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}};
				request options, (error, response, body) ->
					body = JSON.parse(body)
					message=body.Iteration.Name+" || "+body.Iteration.ObjectID+" || "+body.Iteration.State+"\n"
					console.log(message)
					msg.send message

				


	
	#delete Feature
	robot.respond /delete feature (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"portfolioitem/feature/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully :+1::thumbsup:")
					msg.send("Deleted Successfully") 
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
				
	#delete Epic
	robot.respond /delete Epic (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"portfolioitem/initiative/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully ")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
	
	#delete Userstory	
	robot.respond /delete UserStory (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"hierarchicalrequirement/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully ")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
	
	#delete Bug	
	robot.respond /delete Bug (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"defect/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully ")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
	

	#delete Task
	robot.respond /delete Task (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"task/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
				
	#delete Testcase
	robot.respond /delete TestCase (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"testcase/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")

	#delete Release
	robot.respond /delete Release (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"release/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")
	
	#delete Iteration
	robot.respond /delete Iteration (.*)/i, (msg) ->
		objectid=msg.match[1]
		url=process.env.API+"iteration/"+objectid;
		options = {url: url,headers:{"Authorization":"Bearer _NA8Bpn3QiaaalAfx0xVJF0USBAFkN7vwMSAV2rQp0"},method:"DELETE"};#auth: {'user': process.env.USERNAME,'pass': process.env.PASSWORD}
		request options, (error, response, body) ->
			body = JSON.parse(body)
			if response.statusCode==200
			
				if body.OperationResult.Errors[0]!=undefined
					console.log(body.OperationResult.Errors[0])
					msg.send(body.OperationResult.Errors[0])
				else 
					console.log("Deleted Successfully")
					msg.send("Deleted Successfully :+1::thumbsup:")
			else
				console.log("Service Not Found")
				msg.send("Service Not Found")

					

			