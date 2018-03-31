class CustomernotesController < ApplicationController

    def index
        @customernotes = Customernote.all
        
        respond_to do |format|
            format.html
            format.pdf do 
                pdf = customernotePdf.new(@customernotes)
                send_data pdf.render, filename: "customernotes List",
                                      type: "application/pdf",
                                      disposition: "inline"
                end
            end
    end

    #Show individual customernote
    def show
        @customernote = Customernote.find(params[:id])

       
    end

    #Create new customernote
    def new
        @customernote = Customernote.new
    end

    #Update an existing customernote
    def edit
    @customernote = Customernote.find(params[:id])

    end

    #Create new customernote
    def create
        @customernote = Customernote.new(note_params)
            
        if @customernote.save
        redirect_to @customernote
        else
            render 'new'
        end
    end

    #Update the customernote
    def update
        @customernote = Customernote.find(params[:id])

        if @customernote.update(note_params)
            redirect_to @customernote
        else
            render 'edit'
        end
    end

    #Delete the customernote
    def destroy
        @customernote = Customernote.find(params[:id])
        @customernote.destroy

        redirect_to customernotes_path
    end

    #Define the needed Parameters, A more secure way to send them.
    private
    def note_params
        params.require(:customernote).permit(:NoteID, :CustomerID, :EmployeeID, 
        :NoteDateTime, :NoteTypeID, :Note, :ResolutionDateTime, :Resolution, :Resolved)
    end

end
