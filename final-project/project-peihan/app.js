'use strict';
const http = require('http');
var assert = require('assert');
const express= require('express');
const app = express();
const mustache = require('mustache');
const filesystem = require('fs');
const url = require('url');
const port = Number(process.argv[2]);

const hbase = require('hbase')
var hclient = hbase({ host: process.argv[3], port: Number(process.argv[4]), encoding: 'latin1'})

function counterToNumber(c) {
	return Number(Buffer.from(c, 'latin1').readBigInt64BE());
}
function rowToMap(row) {
	var stats = {}
	row.forEach(function (item) {
		stats[item['column']] = counterToNumber(item['$'])
	});
	return stats;
}

hclient.table('trips_agg').row('Aberdeen St & Randolph St-Michigan Ave & 18th St').get((error, value) => {
	console.info(rowToMap(value))
	console.info(value)
})


hclient.table('trips_agg').row('Aberdeen St & Randolph St-Michigan Ave & 18th St').get((error, value) => {
	console.info(rowToMap(value))
	console.info(value)
})


app.use(express.static('public'));
app.get('/trips.html',function (req, res) {
    const trip=req.query['started'] + req.query['ended];
    console.log(trip);
	hclient.table('trips_agg').row(trip).get(function (err, cells) {
		const tripInfo = rowToMap(cells);
		console.log(tripInfo)
		function num_rides(member_casual,month) {
			var number_rides = tripInfo["num_rides_" + member_casual+"_"+month];
			return (number_rides).toFixed(1); /* One decimal place */
		}

		var template = filesystem.readFileSync("result.mustache").toString();
		var html = mustache.render(template,  {
			started : req.query['started'],
			ended : req.query['ended'],
			member_jan : num_rides("member","jan"),
			member_feb : num_rides("member","feb"),
			member_mar : num_rides("member","mar"),
			member_apr : num_rides("member","apr"),
			member_may : num_rides("member","may"),
			member_jun : num_rides("member","jun"),
			member_jul : num_rides("member","jul"),
			member_aug : num_rides("member","aug"),
			member_sep : num_rides("member","sep"),
			member_oct : num_rides("member","oct"),
			member_nov : num_rides("member","nov"),
			member_dec : num_rides("member","dec"),
			casual_jan : num_rides("casual","jan"),
			casual_feb : num_rides("casual","feb"),
			casual_mar : num_rides("casual","mar"),
			casual_apr : num_rides("casual","apr"),
			casual_may : num_rides("casual","may"),
			casual_jun : num_rides("casual","jun"),
			casual_jul : num_rides("casual","jul"),
			casual_aug : num_rides("casual","aug"),
			casual_sep : num_rides("casual","sep"),
			casual_oct : num_rides("casual","oct"),
			casual_nov : num_rides("casual","nov"),
			casual_dec : num_rides("casual","dec"),
		});
		res.send(html);
	});
});


app.listen(port);
