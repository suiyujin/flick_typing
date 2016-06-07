class InputsController < ApplicationController
  before_action :set_input, only: [:show, :edit, :update, :destroy]

  # GET /inputs
  # GET /inputs.json
  def index
    @inputs = Input.includes(:team, :answer).all
  end

  # GET /inputs/1
  # GET /inputs/1.json
  def show
  end

  # GET /inputs/new
  def new
    @input = Input.new
    @team_id = params[:team][:id]
    @answer_id = params[:answer][:id]
  end

  # GET /inputs/1/edit
  def edit
  end

  # POST /inputs
  # POST /inputs.json
  def create
    @input = Input.new(input_params)

    # 改行、タブ、空白など取り除く
    @input.text = @input.text.gsub(/(\s|　)/, '')

    # TODO: 正しいtimeを入れる
    @input.time = '01:00'

    calculate_score

    respond_to do |format|
      if @input.save
        format.html { redirect_to @input, notice: 'Input was successfully created.' }
        format.json { render :show, status: :created, location: @input }
      else
        format.html { render :new }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inputs/1
  # PATCH/PUT /inputs/1.json
  def update
    respond_to do |format|
      if @input.update(input_params)
        format.html { redirect_to @input, notice: 'Input was successfully updated.' }
        format.json { render :show, status: :ok, location: @input }
      else
        format.html { render :edit }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inputs/1
  # DELETE /inputs/1.json
  def destroy
    @input.destroy
    respond_to do |format|
      format.html { redirect_to inputs_url, notice: 'Input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def result
    @results = params[:team_ids].split(',').map do |team_id|
      params[:answer_ids].split(',').map do |answer_id|
        Input.recent_input_by_team_and_answer(team_id, answer_id)
      end.flatten
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input
      @input = Input.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def input_params
      params.require(:input).permit(:text, :team_id, :answer_id)
    end

    def calculate_score
      answer = @input.answer

      diff = check_diff(@input, answer)
      correct = diff[:correct_count]
      miss = diff[:penalty_count]
      binding.pry

      @input.correct_count = correct
      @input.penalty_count = miss
      @input.total_time = '01:00'
    end

    def check_diff(input, answer)
      ## 最長共通部分とdiffの数を調べる
      input.text.extend(Diff::LCS)
      {
        correct_count: input.text.lcs(answer.text).size,
        penalty_count: input.text.diff(answer.text).flatten.size
      }
    end
end
