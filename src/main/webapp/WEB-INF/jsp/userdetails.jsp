/**
 * Created with IntelliJ IDEA.
 * User: gauravmunjal
 * Date: 12/8/12
 * Time: 7:03 PM
 * To change this template use File | Settings | File Templates.
 */
<div class="control-group">
    <label class="control-label"></label>
    <div class="controls">
        <script type="text/javascript"
                src="http://api.recaptcha.net/challenge?k=6LepJNUSAAAAADjXVJ-6vY5223LNYgZbzy3mWgNt">
        </script>
        <noscript>
            <iframe id="captchaImg" name="captchaImg" src="http://api.recaptcha.net/noscript?k=6LepJNUSAAAAADjXVJ-6vY5223LNYgZbzy3mWgNt"
                    height="300" width="500" frameborder="0"></iframe><br>
            <textarea id="captchaText" name="recaptcha_challenge_field" rows="3" cols="40">
            </textarea>
            <input id="manChallenge" type="hidden" name="recaptcha_response_field"
                   value="manual_challenge">
        </noscript>

        <button type="button" onclick="validateCaptcha(this.form.recaptcha_challenge_field.value,this.form.recaptcha_response_field.value);return false;">verify!</button>
        <script type="text/javascript">
            function validateCaptcha(chall,resp){
                var check =false;
                $.ajax({
                    type: "POST",
                    data:$.param({ challenge: chall, response: resp}),
                    url: "/captcha.json",
                    async:false,
                    success: function(result){
                        //alert(result) ;
                        if(result=="yes"){

                            $('#captchaImg').style="display:none";
                            $('#manChallenge').style="display:none";
                            $('#captchaText').style="display:none";
                            $('#regBtn').show();
                            check=true;
                        }


                    }
                });
                //alert (check);
                return check;
            }
        </script>
    </div>
</div>


<div class="control-group">
    <label class="control-label"></label>
    <div class="controls">
        <button type="submit" id ="regBtn" style="display:none" class="btn btn-success" >Create My Account</button>
    </div>
</div>