package tabelas;

public class Laboratorio {
	
	public String nome;
	public String descricao;
	
	public Laboratorio (String nome, String descricao) {
		
		this.nome = nome;
		this.descricao = descricao;
	}
	
	public String getNome() {
		
		return this.nome;
	}
	
	public String getDescricao() {
		
		return this.descricao;
	}
	
	public void setNome(String nome) {
		
		this.nome = nome;
	}
	
	public void setDescricao(String descricao) {
		
		this.nome = descricao;
	}
	
}
