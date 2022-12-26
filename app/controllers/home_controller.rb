# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  before_action :check_input, only: :result
  def input; end

  def result
    @arr = params[:arr]
    @num = params[:num]
    @side = params[:side]
    my_url = URL + "&num=#{@num}&arr=#{@arr}"
    server_result = URI.open(my_url)
    check_response = URI.open(my_url)
    if Nokogiri::XML(check_response).to_s == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nil-classes type=\"array\"/>\n"
      redirect_to root_path, notice: 'Нет отрезков, удовлетворяющих условию'
      return
    end
    if @side == 'client'
      @result = xsl_transform(server_result)
    elsif @side == 'server'
      render xml: server_xslt(server_result)
    elsif @side == 'xml'
      render xml: Nokogiri::XML(server_result)
    end
  end

  private
  URL = 'http://localhost:3000/?format=xml'
  SERV_TRANS = "#{Rails.root}/public/transform.xslt".freeze
  BROWS_TRANS = '/transform.xslt'.freeze

  def xsl_transform(server)
    xml = Nokogiri::XML(server)
    xslt = Nokogiri::XSLT(File.read(SERV_TRANS))
    xslt.transform(xml)
  end

  def server_xslt(server, transform: BROWS_TRANS)
    doc = Nokogiri::XML(server)
    xslt = Nokogiri::XML::ProcessingInstruction.new(
      doc,'xml-stylesheet', 'type="text/xsl" href="' + transform + '"')
    doc.root.add_previous_sibling(xslt)
    doc
  end

  def check_input
    a = params[:arr]
    n = params[:num].to_i
    redirect_to root_path, alert: 'Заданное количество элементов не совпадает с реальным' if n != a.split.length
    return if a.match(/^\s*(\d+\s*)*$/)

    redirect_to root_path, alert: 'Неправильный ввод'
  end
end
