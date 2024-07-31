report 50332 Enquiries
{
    caption = 'Visitor Interactions';
    DefaultLayout = RDLC;
    RDLCLayout = './Enquiries.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Enquiries Book"; "Enquiries Book")
        {
            DataItemTableView = SORTING("Serial Number");
            RequestFilterFields = "Serial Number";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            /*             column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        } */
            column(USERID; UserId)
            {
            }
            column(Enquiries_Book__Serial_Number_; "Serial Number")
            {
            }
            column(Enquiries_Book__Name_of_Customer_; "Name of Customer")
            {
            }
            column(Enquiries_Book__I_D_No__; "I.D No.")
            {
            }
            column(Enquiries_Book__SF_No__; "SF No.")
            {
            }
            column(Visitor_type; "Visitor type")
            {
            }
            column(Visiting_Department; "Visiting Department")
            {
            }
            column(Purpose_of_Visit; "Purpose of Visit")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Status; Status)
            {
            }
            column(Enquiries_Book__Complaint_Request_Submitted_; "Complaint/Request Submitted")
            {
            }
            column(Enquiries_Book__Customer_Remarks_; "Customer Remarks")
            {
            }
            column(Enquiries_Book__Satisfaction_Level_; "Satisfaction Level")
            {
            }
            column(Enquiries_Book_Status; Status)
            {
            }
            column(Enquiries_Book__Time_In_; "TimeIn")
            {
            }
            column(Enquiries_Book__Time_Out_; "TimeOut")
            {
            }
            column(Enquiries_Book_Duration; Duration)
            {
            }
            column(Enquiries_BookCaption; Enquiries_BookCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Enquiries_Book__Serial_Number_Caption; FieldCaption("Serial Number"))
            {
            }
            column(Enquiries_Book__Name_of_Customer_Caption; FieldCaption("Name of Customer"))
            {
            }
            column(Enquiries_Book__I_D_No__Caption; FieldCaption("I.D No."))
            {
            }
            column(Enquiries_Book__SF_No__Caption; FieldCaption("SF No."))
            {
            }
            column(Enquiries_Book__Complaint_Request_Submitted_Caption; FieldCaption("Complaint/Request Submitted"))
            {
            }
            column(Enquiries_Book__Customer_Remarks_Caption; FieldCaption("Customer Remarks"))
            {
            }
            column(Enquiries_Book__Satisfaction_Level_Caption; FieldCaption("Satisfaction Level"))
            {
            }
            column(Enquiries_Book_StatusCaption; FieldCaption(Status))
            {
            }
            column(Enquiries_Book__Time_In_Caption; FieldCaption("TimeIn"))
            {
            }
            column(Enquiries_Book__Time_Out_Caption; FieldCaption("TimeOut"))
            {
            }
            column(Enquiries_Book_DurationCaption; FieldCaption(Duration))
            {
            }
            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Serial Number");
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
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Enquiries_BookCaptionLbl: Label 'Enquiries Book';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}
