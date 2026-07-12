import { useState, useEffect } from 'react'
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom'
import { Analytics } from './Analytics.tsx'
import './App.css'

function Home() {
    const [fullUrl, setFullUrl]=useState(()=> {return localStorage.getItem('saved_full_url')||'';});
    const [shortUrl, setShortUrl]=useState(()=>{return localStorage.getItem('saved_short_url') ||'';});
    useEffect(()=> {
        localStorage.setItem('saved_full_url', fullUrl);
    },[fullUrl]);
    useEffect(()=> {
        localStorage.setItem('saved_short_url', shortUrl);
    },[shortUrl]);
    const pgName='https://api.lnks.website';
    const [badResp, setBadResp]=useState(false);

  const handleShorten = async() => {
      try{
          const response = await fetch(pgName+"/api/v1/shorten", {
              method: 'POST',
              headers: {
                    'Content-Type': 'application/json'
                  },
              body: JSON.stringify({full_url: fullUrl}),
             });

          if (response.ok){
              const data = await response.json();
              setShortUrl(pgName+'/'+data.short_url);
              }
          else{
              setBadResp(true)
              console.error("Backend error!")
              }
      }
      catch (error){
          console.error("Error while connecting to the server!")
      }
  };

  const shortCode = shortUrl.split('/').pop();

  return (
      <div className="main-container">
                <h2>Shortify - Shorten any link you want!</h2>
                <form
                onSubmit={(e)=>{
                    setShortUrl('')
                    setBadResp(false)
                    e.preventDefault();
                    handleShorten();
                    }}>
                <input
                    type="text"
                    value={fullUrl}
                    placeholder={'Enter your link'}
                    onChange={(e)=>setFullUrl(e.target.value)}
                    />
                <button
                    type="submit"
                >
                    Shortify!
                </button>
          </form>
          <div className="sub-container">
                {shortUrl &&
                    <div>
                        <p>This is your shortified link:</p>
                        <a href={shortUrl} target="_blank">{shortUrl}</a>
                        <Link to={"/stats/"+shortCode}>
                            <button style={{marginLeft: "10px"}}>View Stats</button>
                        </Link>
                    </div>
                    }
                {badResp &&
                    <div className="err-txt">
                        <p>Error: this is not a valid link</p>
                    </div>
                    }
          </div>
      </div>
  )
}


function App(){
    return(
        <BrowserRouter>
            <Routes>
                <Route path='/' element={<Home />} />
                <Route path='/stats/:shortCode' element={<Analytics />}/>
            </Routes>
        </BrowserRouter>
    )
}

export default App
