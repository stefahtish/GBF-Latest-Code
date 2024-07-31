report 50335 "Client Interactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ClientInteractions.rdlc';
    ApplicationArea = All;

    //WordLayout = './ClientInteractions.docx';
    dataset
    {
        dataitem("Client Interaction Header"; "Client Interaction Header")
        {
            DataItemTableView = SORTING("Interact Code");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Interaction Type", "Interaction Channel", Status, "Date and Time", "Client Type";

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
            column(Client_Interaction_Header__Client_Name_; "Client Name")
            {
            }
            column(Client_Interaction_Header__Date_and_Time_; "Date and Time")
            {
            }
            column(Client_Interaction_Header_Notes; Notes)
            {
            }
            column(Client_Interaction_Header__Interaction_Channel_; "Interaction Channel")
            {
            }
            column(Client_Interaction_Header__User_ID_; "User ID")
            {
            }
            column(Client_Interaction_Header_Status; Status)
            {
            }
            column(Client_Interaction_Header__Interaction_Type_No__; "Interaction Type No.")
            {
            }
            column(Client_Interaction_Header__Interaction_Type_; "Interaction Type")
            {
            }
            column(Client_Interaction_Header__Client_Feedback_; "Client Feedback")
            {
            }
            column(Client_Interaction_Header__Last_Updated_Date_and_Time_; "Last Updated Date and Time")
            {
            }
            column(Counter; Counter)
            {
            }
            column(Client_Interaction_HeaderCaption; Client_Interaction_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Client_Interaction_Header__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Client_Interaction_Header__Date_and_Time_Caption; FieldCaption("Date and Time"))
            {
            }
            column(Client_Interaction_Header_NotesCaption; FieldCaption(Notes))
            {
            }
            column(Client_Interaction_Header__Interaction_Channel_Caption; FieldCaption("Interaction Channel"))
            {
            }
            column(Client_Interaction_Header__User_ID_Caption; FieldCaption("User ID"))
            {
            }
            column(Client_Interaction_Header_StatusCaption; FieldCaption(Status))
            {
            }
            column(Client_Interaction_Header__Interaction_Type_No__Caption; FieldCaption("Interaction Type No."))
            {
            }
            column(Client_Interaction_Header__Interaction_Type_Caption; FieldCaption("Interaction Type"))
            {
            }
            column(Client_Interaction_Header__Client_Feedback_Caption; FieldCaption("Client Feedback"))
            {
            }
            column(Client_Interaction_Header__Last_Updated_Date_and_Time_Caption; FieldCaption("Last Updated Date and Time"))
            {
            }
            column(CounterCaption; CounterCaptionLbl)
            {
            }
            column(Client_Interaction_Header_Interact_Code; "Interact Code")
            {
            }
            dataitem("Resolution of Tasks Status"; "Resolution of Tasks Status")
            {
                DataItemLink = "Interaction Header No." = FIELD("Interact Code");
                DataItemLinkReference = "Client Interaction Header";

                column(Client_Interaction_Header___Client_Name_; "Client Interaction Header"."Client Name")
                {
                }
                column(Resolution_of_tasks_Status__Interation_Reso__Code_; "Interation Reso. Code")
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Code_; "Interaction Header No.")
                {
                }
                column(Resolution_of_tasks_Status__Step_No__; "Step No.")
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Description_; "Resolution Description")
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Status_; "Resolution Status")
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Code_Caption; FieldCaption("Interaction Header No."))
                {
                }
                column(Resolution_of_tasks_Status__Interation_Reso__Code_Caption; FieldCaption("Interation Reso. Code"))
                {
                }
                column(Resolution_of_tasks_Status__Step_No__Caption; FieldCaption("Step No."))
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Description_Caption; FieldCaption("Resolution Description"))
                {
                }
                column(Resolution_of_tasks_Status__Resolution_Status_Caption; FieldCaption("Resolution Status"))
                {
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Vendor.Get("Client Interaction Header"."Client No.") then begin
                end;
            end;

            trigger OnPreDataItem()
            begin
                //LastFieldNo := FIELDNO("Interact Code");
                Counter := 0;
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
        Vendor: Record Vendor;
        Counter: Integer;
        Client_Interaction_HeaderCaptionLbl: Label 'Client Interaction Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CounterCaptionLbl: Label 'Counter';
        ContinuedCaptionLbl: Label 'Continued';
}
