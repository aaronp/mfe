import { json, type RequestHandler } from '@sveltejs/kit'

// /component GET

const dashboardHost = "http://dashboard-bff-service.mfe:8080";

export const GET: RequestHandler = async (event) => {
  const options: ResponseInit = {
    status: 200,
    headers: {
      'Content-Type': 'application/json'
    }
  }

  try {
    var response = await fetch(new URL("/component", dashboardHost));
    return new Response('listing services returned ' + response, options);
  } catch(e) {
    return new Response('listing services threw ' + e, options);
  }

}

// /component POST

export const POST: RequestHandler = async (event) => {
  // const data = await event.request.formData()
  // const email = data.get('email')

  // // subscribe the user to the newsletter
  // console.log(email)

  // return success
  return new Response(JSON.stringify({ worked: true }), {
    headers: {
      'Content-Type': 'application/json'
    }
  })
}
