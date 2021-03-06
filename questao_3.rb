require 'yaml'
CFG = YAML.load_file('./utils/format_1.yaml')

require './utils/input.rb'

def normaliza_string(key, value, params)
  len = params['length'].to_i

  value = remove_padding(value, params['align'], params['spaces'], len)

  value
end

def remove_padding(value, align, type, len)
  space = type == 'spaces' ? ' ' : '0'
  return value.strip() if type == 'spaces'
  {
    left: value.sub!(/^[0]+/,''),
    right: value.reverse.sub!(/^[0]+/,'').reverse,
  }[align.to_sym] || value
end

def solucao(arg)
  posicao_inicial = 0
  obj = {}

  CFG.keys.each do |key|
    value = arg[posicao_inicial, CFG[key]['length'].to_i]
    obj[key] = normaliza_string(key, value, CFG[key])
    posicao_inicial += CFG[key]['length'].to_i 
  end

  obj
end

puts solucao(INPUT_2)
