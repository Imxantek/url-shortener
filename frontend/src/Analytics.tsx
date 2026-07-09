import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import './App.css'

import {
    Bar,
    BarChart,
    XAxis,
    YAxis,
    ResponsiveContainer,
    LineChart,
    Line,
    Legend,
    PieChart,
    Pie,
    Tooltip, Cell
} from 'recharts';


export interface AnalyticsData {
    short_url: string;
    total_clicks: number;
    countries?: Record<string, number>;
    browsers?: Record<string, number>;
    click_times?: Record<string, number>;
}



export function Analytics(){
    const { shortCode }=useParams();
    const navigate=useNavigate();
    const [data, setData]=useState<AnalyticsData | null>(null)
    const [error, setError]=useState(false);
    const pgName="http://127.0.0.1:5000";
    const [activeIndex, setActiveIndex] = useState<number | null>(null);

    const formatChartData = (record?: Record<string, number>) => {
        if (!record) return [];
        return Object.entries(record).map(([key, val]) => ({
            name: key,
            value: val
        }));
    };

    function drawCountries(){
        if(!data || !data.countries) return null
        const chartData=formatChartData(data.countries)

        return(
            <div className="chart-div">
                <ResponsiveContainer width="100%" height="100%">
                    <PieChart width="100%" height="100%">
                        <Pie
                            data={chartData}
                            dataKey={"value"}
                            nameKey={"name"}
                            isAnimationActive={true}
                            onMouseEnter={(_, index)=>setActiveIndex(index)}
                            onMouseLeave={()=>setActiveIndex(null)}

                        >
                            {chartData.map((_entry, index) => (
                                <Cell
                                    key={`cell-${index}`}
                                    fill={activeIndex === index ? "#aa3bff" : "#e5e4e7"}
                                    style={{ transition: 'fill 0.3s ease' }}
                                />
                            ))}
                        </Pie>
                        <Legend />
                        <Tooltip />
                    </PieChart>
                </ResponsiveContainer>
            </div>
        )
    }

    function drawClicks(){
        if(!data || !data.click_times) return null
        const chartData=formatChartData(data.click_times)
        // @ts-ignore
        return(
            <div className="chart-div">
                <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={chartData}>
                        <Line dataKey="value" name={"Clicks in last 7 days"} stroke="#aa3bff"/>
                        <XAxis dataKey="name"/>
                        <YAxis />
                        <Legend />
                        <Tooltip formatter={(value: number) => [value, "Clicks"]}
                        />
                    </LineChart>
                </ResponsiveContainer>
            </div>
        )
    }

    function drawBrowsers(){
        if(!data || !data.browsers) return null
        const chartData=formatChartData(data.browsers)
        return(
            <div className="chart-div">
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        layout={"vertical"}
                        data={chartData}
                        margin={{ top: 5, right: 30, left: 150, bottom: 5 }}
                    >
                        <Bar
                            dataKey="value"
                            fill="#aa3bff"
                            radius={[0,4,4,0]}
                            name={"Browser"}
                            />
                        <YAxis dataKey="name" type="category" width={140}/>
                        <XAxis type="number"/>
                        <Legend />
                        <Tooltip cursor={{fill: 'transparent'}} />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        )

    }








    useEffect(()=>{
        const fetchStats = async () =>{
            try{
                const response = await fetch(pgName+"/api/v1/analytics/"+shortCode);
                if(response.ok){
                    const result: AnalyticsData = await response.json();
                    setData(result);
                }
                else{
                    setError(true);
                }
            }catch(err){
                setError(true);
            }
        }
        if (shortCode) {
            fetchStats();
        }
    }, [shortCode]);
    if(error) return(<><p>Error while accessing analytics</p><button onClick={()=>navigate('/')}>Go back</button></>)
    if(!data) return(<p>Loading...</p>)




    return(
        <div className="main-container">
            <h2>Analytics for: {data.short_url}</h2>
            <p>Total clicks: <strong>{data.total_clicks}</strong></p>
            <div className="sub-container" style={{width: "100%", maxWidth: "800px"}}>


                {drawClicks()}
                {drawCountries()}
                {drawBrowsers()}
                <button onClick={() => navigate('/')}>
                    Back to Shortify
                </button>
            </div>
        </div>
    )
}

export default Analytics;