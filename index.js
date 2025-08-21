const fetch = require('node-fetch');

const KANDILLI_URL = 'https://api.orhanaydogdu.com.tr/deprem/kandilli/live';

let sonDepremIds=new Set();
async function depremGetir() {
  try {
    const response = await fetch(KANDILLI_URL);
    const data = await response.json();
   // const yenidepremler=sondepremids.

    const yeniDepremler = data.result.filter(deprem => !sonDepremIds.has(deprem._id));
    yeniDepremler.forEach(deprem => {
        console.log('Yeni deprem var! ');
      console.log(`Başlık: ${deprem.title}, Şiddet: ${deprem.mag}`);
      sonDepremIds.add(deprem._id);
      
    });
     if(yeniDepremler.length===0){
      console.log("Yeni Deprem Yok");
     }
  } catch (error) {
    console.log('Hata oluştu:', error);
  }
}

depremGetir();

setInterval(depremGetir, 60 * 1000);

