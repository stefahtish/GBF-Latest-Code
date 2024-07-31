report 50334 "Interaction Notes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InteractionNotes.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Client Interaction Header"; "Client Interaction Header")
        {
            DataItemTableView = SORTING("Interact Code");
            RequestFilterFields = "Client No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            /*             column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        } */
            column(USERID; UserId)
            {
            }
            column(Client_Interaction_Header__Interact_Code_; "Interact Code")
            {
            }
            column(Client_Interaction_Header__Date_and_Time_; "Date and Time")
            {
            }
            column(Client_Interaction_Header__Client_No__; "Client No.")
            {
            }
            column(Client_Interaction_Header__Client_Name_; "Client Name")
            {
            }
            column(Client_Interaction_Header__Interaction_Type_; "Interaction Type")
            {
            }
            column(Client_Interaction_Header__Interaction_Type_Desc__; "Interaction Type Desc.")
            {
            }
            column(Client_Interaction_Header_Notes; Notes)
            {
            }
            column(Interaction_NotesCaption; Interaction_NotesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Client_Interaction_Header__Interact_Code_Caption; FieldCaption("Interact Code"))
            {
            }
            column(Client_Interaction_Header__Date_and_Time_Caption; FieldCaption("Date and Time"))
            {
            }
            column(Client_Interaction_Header__Client_No__Caption; FieldCaption("Client No."))
            {
            }
            column(Client_Interaction_Header__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Client_Interaction_Header__Interaction_Type_Caption; FieldCaption("Interaction Type"))
            {
            }
            column(Client_Interaction_Header__Interaction_Type_Desc__Caption; FieldCaption("Interaction Type Desc."))
            {
            }
            column(Client_Interaction_Header_NotesCaption; FieldCaption(Notes))
            {
            }
            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Interact Code");
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Interaction_NotesCaptionLbl: Label 'Interaction Notes';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}
