module Api 
  module V1

    class AppointmentsController < ApplicationController
      around_action :measure_create_time, only: [:create]
      before_action :set_appointment, only: [:show, :edit, :update,:destroy]
    
      def index
        @appointments = Appointment.all
      
        # @patient = Patient.find(params[:patient_id])
        # @appointments = @patient.appointments
        # # @doctor = Doctor.find(params[:doctor_id])
        # # @appointments  = @doctor.appointments
      
        # # render json: @appointments
      end
    
      def new
        @appointment = Appointment.new
      end
    
      def create
        # Rails.logger.info "Method #{request.method}"
        # Rails.logger.info "Format #{request.format}"
        # Rails.logger.info "Remote IP #{request.remote_ip}"
        # Rails.logger.info "User agent #{request.user_agent}"
      
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
          # render json: @appointment, status: :created
          # flash[:notice] = "Appointment booked successfully."
          # redirect_to appointments_path
          redirect_to appointments_path, notice: "Appointment Added successfully"
        else
          # render json: { errors: @appointment.errors }, status: :unprocessable_entity
          flash.now[:alert] = "Could not book appointment: #{@appointment.errors.full_messages.join(', ')}"
        
          render :new, status: :unprocessable_entity
        end
      end 
    
      def show 
        respond_to do |format| 
          format.html 
          format.json { render json: @appointment }
        end
      end
    
      def edit 
      end
    
      def update
        if @appointment.update(appointment_params)
          redirect_to appointments_path, notice: "Appointment Updated successfully"
        else
          render :edit, status: :unprocessable_entity
        end
      end 
      
      def destroy
        @appointment.destroy
      
        redirect_to appointments_path, notice: "Appointment deleted successfully"
      end
    
      def cancel
        @appointment = Appointment.find(params[:id])
        @appointment.update(status: "cancelled")
      
        redirect_to @appointment
      end
    
      def upcoming
        @appointments = Appointment.where("appointment_date > ?", Date.today)
      
        render json: @appointments
      end
      
      private
    
      def appointment_params
        params.require(:appointment).permit(:reason, :doctor_id, :patient_id, :appointment_date)
      end
    
      def set_appointment
        @appointment = Appointment.find(params[:id])
      end
    
      def measure_create_time 
        start_time = Time.current
        yield
        duration = (Time.current - start_time) * 1000
        Rails.logger.info "Appointment creation took #{duration.round(2)}ms"
      end
    end