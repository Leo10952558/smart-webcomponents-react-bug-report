<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Article;
use App\Models\SystemLog;
use App\Models\TableMap;
use App\Models\Budgets;
use App\Models\Constructions;
use App\Http\Requests\StoreArticleRequest;
use App\Http\Requests\UpdateArticleRequest;

class ArticleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $articles = Article::all();
        $articles = $articles->where('deleted', null)->values();
        if (isset($request->id)) {
            $articles = $articles->where('id', $request->id)->values();
        }
        if (isset($request->name)) {
            $articles = $articles->where('name', $request->name)->values();
        }
        if (isset($request->is_house)) {
            $articles = $articles->where('is_house', $request->is_house)->values();
        }
        if (isset($request->ended)) {
            $articles = $articles->where('ended', $request->ended)->values();
        }

        foreach ($articles as $article) {

            $user_created = User::select('*')->where('id', $article->created_user_id)->first();
            $user_updated = User::select('*')->where('id', $article->updated_user_id)->first();
            $article['created_user_name'] = $user_created->first_name . ' ' . $user_created->last_name;
            $article['updated_user_name'] = $user_updated->first_name . ' ' . $user_updated->last_name;
            // var_dump($article);
        }
        //  exit();


        return response()->json([
            'success' => true,
            'data' => $articles,
            'message' => 'Articles successfully scraped.'
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(StoreArticleRequest $request)
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreArticleRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'contract_amount' => 'required|numeric',
            'is_house' => 'required|numeric'
        ]);
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
                'message' => 'Article validation error.'
            ]);
        }
        // role permission related code should be written here!

        $user = Auth::user();
        $data['created_user_id'] = $user->id;
        $data['updated_user_id'] = $user->id;

        $data['name'] = $request['name'];
        $data['contract_amount'] = $request['contract_amount'];
        $data['ended'] = $request['ended'];
        $data['is_house'] = $request['is_house'];
        $article = Article::create($data);
        // echo('here suc'); exit();

        return response()->json([
            'success' => true,
            'article' => $article,
            'message' => 'Article and Budget successfully added.'
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function show(Article $article)
    {
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function edit(Article $article)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateArticleRequest  $request
     * @param  \App\Models\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateArticleRequest $request, Article $article)
    {
        $user = Auth::user();
        $request['updated_user_id'] = $user->id;
        $article['updated_at'] = Carbon::now()->format('Y-m-d H:i:s');

        $article->update($request->all());

        return response()->json([
            'success' => true,
            'data' => $article
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function destroy(Article $article)
    {
        $user = Auth::user();
        $request['updated_user_id'] = $user->id;

        $article['deleted'] = Carbon::now()->format('Y-m-d H:i:s');

        $article->update(['deleted' => $article['deleted']]);


        return response()->json([
            'success' => true
        ]);
    }
}
