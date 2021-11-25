require 'rails_helper'

feature "customers", type: :feature do
  scenario 'Verifica o link Cadastro de Clientes' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica link de novo cliente' do
    visit(root_path)
    click_on('Cadastro de Clientes')
    expect(page).to have_content('Listando Clientes')
    expect(page).to have_link('Novo Cliente')
  end

  scenario 'Verifica Formulário de novo cliente' do
    visit(customers_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo cliente')
  end

  scenario 'Cadastra um cliente válido' do
    visit(new_customer_path)

    customer_name = Faker::Name.name

    fill_in('Name', with: customer_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Phone', with: Faker::PhoneNumber.phone_number)
    attach_file('Avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['S', 'N'].sample)
    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Não cadastra um cliente inválido' do
    visit(new_customer_path)
    click_on('Criar Cliente')
    expect(page).to have_content('Name can\'t be blank')
  end

  scenario 'Mostra um client' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['S', 'N'].sample
    )
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
    expect(page).to have_content(customer.smoker)
  end

  scenario 'Testando a index' do
    customer1 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['S', 'N'].sample
    )
    customer2 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['S', 'N'].sample
    )

    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

end
