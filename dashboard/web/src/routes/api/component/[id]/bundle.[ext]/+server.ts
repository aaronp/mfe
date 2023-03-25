import { json, type RequestHandler } from '@sveltejs/kit'

export const GET: RequestHandler = async (event) => {
  const segments = event.url.pathname.split('/');
  const id = segments[segments.length - 2];
  const file = segments[segments.length - 1];
  console.log(`proxy getting ${file} from ${id} `);
  const r = await fetch(new URL(`component/${id}/${file}`, "http://localhost:8081"));
  return r;
}

