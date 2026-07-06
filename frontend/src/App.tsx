import { useState } from 'react'
import './App.css'

function App() {
  const [fullUrl, setFullUrl]=useState('')
  const [shortUrl, setShortUrl]=useState('')
  const pgName=useState('http://127.0.0.1:5000')
  const [badResp, setBadResp]=useState(false)
  const handleShorten = async(e: React.FormEvent) => {
      console.log("this is the api command: ")
      console.log(pgName[0].concat("/api/v1/shorten"))
      try{
          const response = await fetch(pgName[0].concat("/api/v1/shorten"),{
              method: 'POST',
              headers: {
                    'Content-Type': 'application/json'
                  },
              body: JSON.stringify({full_url: fullUrl}),
             });

          if (response.ok){
              const data = await response.json();
              setShortUrl(pgName[0].concat('/', data.short_url));
              }
          else{
              setBadResp(true)
              console.error("Backend error!")
              }
          }catch (error){
              console.error("Error while connecting to the server!")
              }
      };

  return (
    <>
      <div>
            <p>Shortify - Shorten any link you want!</p>
            <form

                onSubmit={(e)=>{
                    setShortUrl('')
                    setBadResp(false)
                    e.preventDefault();
                    handleShorten(e);
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
            {shortUrl &&
                <div>
                    <p>This is your shortified link:</p>
                    <a href={shortUrl}>{shortUrl}</a>
                </div>
                }
            {badResp &&
                <div>
                    <p>Error: this is not a valid link</p>
                </div>
                }
      </div>
    </>
  )
}

export default App
